"""Exercise entry points and role behavior in temporary directories only."""

import getpass
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

import yaml

ROOT = Path(__file__).resolve().parents[1]
ANSIBLE = (
    str(ROOT / ".venv/bin/ansible-playbook")
    if (ROOT / ".venv/bin/ansible-playbook").exists()
    else shutil.which("ansible-playbook")
)
ROLES = ROOT / "ansible/roles"


class AnsibleFixture(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="dotfiles-test-")
        self.addCleanup(self.temp.cleanup)
        self.base = Path(self.temp.name).resolve()
        self.env = {
            **os.environ,
            "ANSIBLE_CONFIG": str(ROOT / "ansible/ansible.cfg"),
            "ANSIBLE_ROLES_PATH": str(self.base / "roles") + os.pathsep + str(ROLES),
            "ANSIBLE_NOCOLOR": "1",
        }

    def play(self, tasks, variables=None, success=True, extra_args=()):
        path = self.base / "play.yml"
        path.write_text(
            yaml.safe_dump(
                [
                    {
                        "name": "Temporary role regression test",
                        "hosts": "localhost",
                        "gather_facts": False,
                        "vars": {
                            "ansible_become": False,
                            "ansible_python_interpreter": sys.executable,
                            **(variables or {}),
                        },
                        "tasks": tasks,
                    }
                ]
            )
        )
        result = subprocess.run(
            [ANSIBLE, "-i", "localhost,", "-c", "local", str(path), *extra_args],
            cwd=ROOT,
            env=self.env,
            text=True,
            capture_output=True,
        )
        if success:
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        else:
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
        return result.stdout + result.stderr


class ProvisioningTest(AnsibleFixture):
    def test_bootstrap_runs_system_then_pinned_home_manager(self):
        calls = self.base / "calls.jsonl"
        executable = self.base / "command"
        executable.write_text(
            f"#!{sys.executable}\nimport json,os,sys\n"
            "with open(os.environ['TEST_CALLS'], 'a') as f:\n"
            " f.write(json.dumps({'args':sys.argv[1:], 'config':os.environ['ANSIBLE_CONFIG']})+'\\n')\n"
            "sys.exit(int(os.environ.get('TEST_EXIT','0')))\n"
        )
        executable.chmod(0o755)
        args = [
            "make",
            "INVENTORY_FILE=hosts_macos",
            "ANSIBLE_ARGS=",
            "HOME_MANAGER_BACKUP_EXT=backup-test",
            f"ANSIBLE_PLAYBOOK={executable}",
            f"NIX={executable}",
        ]
        result = subprocess.run(
            args,
            cwd=ROOT,
            env={**self.env, "TEST_CALLS": str(calls)},
            text=True,
            capture_output=True,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        events = [json.loads(line) for line in calls.read_text().splitlines()]
        self.assertEqual(len(events), 2)
        self.assertIn("ansible/macos.yml", events[0]["args"])
        self.assertEqual(events[0]["config"], str(ROOT / "ansible/ansible.cfg"))
        self.assertEqual(
            events[1]["args"],
            [
                "run",
                str(ROOT / "nix") + "#home-manager",
                "--",
                "switch",
                "-b",
                "backup-test",
                "--flake",
                str(ROOT / "nix") + "#macosx",
            ],
        )
        calls.unlink()
        failed = subprocess.run(
            args,
            cwd=ROOT,
            env={**self.env, "TEST_CALLS": str(calls), "TEST_EXIT": "37"},
            text=True,
            capture_output=True,
        )
        self.assertNotEqual(failed.returncode, 0)
        self.assertEqual(len(calls.read_text().splitlines()), 1)

    def test_make_selects_matching_playbook_without_host_pattern_warnings(self):
        for inventory, play in (
            ("hosts_macos", "Set up macOS workstation"),
            ("hosts_gentoo", "Set up Gentoo workstation"),
        ):
            for target in ("install", "run"):
                with self.subTest(inventory=inventory, target=target):
                    result = subprocess.run(
                        [
                            "make",
                            target,
                            f"INVENTORY_FILE={inventory}",
                            "ANSIBLE_ARGS=--list-tasks",
                        ],
                        cwd=ROOT,
                        env=self.env,
                        text=True,
                        capture_output=True,
                    )
                    self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                    self.assertIn(play, result.stdout)
                    self.assertNotIn("Could not match supplied host pattern", result.stderr)

    def test_nix_flakes_tag_reaches_tasks_and_their_prerequisites(self):
        result = subprocess.run(
            [
                ANSIBLE,
                "-i",
                "ansible/hosts_macos",
                "ansible/macos.yml",
                "--list-tasks",
                "--tags",
                "nix_flakes",
            ],
            cwd=ROOT,
            env=self.env,
            text=True,
            capture_output=True,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("Ensure Nix Flakes features are enabled", result.stdout)
        self.assertIn("Set fact for Nix config directory path", result.stdout)
        self.assertNotIn("Run installer script", result.stdout)

    def test_flakes_configuration_is_idempotent(self):
        variables = {
            "nix_installer_config_dir_path": str(self.base),
            "nix_installer_user": getpass.getuser(),
        }
        tasks = [
            {
                "ansible.builtin.import_tasks": str(
                    ROLES / "nix_installer/tasks/setup-flakes.yml"
                )
            }
        ]
        self.play(tasks, variables)
        config = (self.base / "nix.conf").read_text()
        self.assertIn("experimental-features = nix-command flakes", config)
        output = self.play(tasks, variables)
        self.assertRegex(output, r"changed=0\b")
        self.assertEqual((self.base / "nix.conf").read_text(), config)

    def test_existing_nix_profile_prevents_reinstall_before_path_is_loaded(self):
        profile_bin = self.base / ".nix-profile/bin"
        profile_bin.mkdir(parents=True)
        (profile_bin / "nix").write_text("existing nix")
        mock_bin = self.base / "bin"
        mock_bin.mkdir()
        which = mock_bin / "which"
        which.write_text("#!/bin/sh\nexit 1\n")
        which.chmod(0o755)
        self.env["PATH"] = str(mock_bin) + os.pathsep + os.environ["PATH"]
        tasks = [
            {
                "ansible.builtin.include_role": {
                    "name": "nix_installer",
                    "tasks_from": "install-nix.yml",
                }
            },
            {"ansible.builtin.assert": {"that": "not nix_installer_should_install"}},
        ]
        variables = {
            "nix_installer_user_details": {"home": str(self.base)},
            "nix_installer_script_dir": str(self.base),
            "nix_installer_download_url": "file:///nonexistent-dotfiles-test-installer",
        }
        for flags in ((), ("--check",)):
            with self.subTest(flags=flags):
                output = self.play(tasks, variables, extra_args=flags)
                self.assertRegex(output, r"changed=0\b")
                self.assertNotIn(
                    "TASK [nix_installer : Run the multi-user installer]", output
                )

    def test_normal_provisioning_does_not_include_storage_migration(self):
        result = subprocess.run(
            [
                ANSIBLE,
                "-i",
                "ansible/hosts_gentoo",
                "ansible/gentoo.yml",
                "--list-tasks",
            ],
            cwd=ROOT,
            env=self.env,
            text=True,
            capture_output=True,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertNotIn("migrate_storage", result.stdout)

    def test_portage_prepares_manifest_before_installing_and_converges(self):
        # Execute the production orchestration with filesystem substitutes for
        # repository setup and emerge. The install substitute requires a manifest.
        role = self.base / "roles/portage_order"
        (role / "tasks").mkdir(parents=True)
        (role / "handlers").mkdir()
        tasks = yaml.safe_load((ROLES / "portage/tasks/main.yml").read_text())
        tasks = [t for t in tasks if "community.general.portage" not in t]
        (role / "tasks/main.yml").write_text(yaml.safe_dump(tasks))
        (role / "tasks/configure_files.yml").write_text(
            yaml.safe_dump(
                [
                    {
                        "ansible.builtin.template": {
                            "src": str(ROLES / "portage/templates/make.conf.j2"),
                            "dest": str(self.base / "make.conf"),
                            "mode": "0644",
                        },
                    }
                ]
            )
        )
        (role / "tasks/manage_overlays.yml").write_text(
            yaml.safe_dump(
                [
                    {
                        "ansible.builtin.copy": {
                            "content": "ebuild",
                            "dest": str(self.base / "ebuild"),
                            "mode": "0644",
                        },
                        "notify": "Generate manifest",
                    }
                ]
            )
        )
        (role / "tasks/install_packages.yml").write_text(
            yaml.safe_dump(
                [
                    {
                        "ansible.builtin.stat": {"path": str(self.base / "Manifest")},
                        "register": "test_manifest",
                    },
                    {"ansible.builtin.assert": {"that": "test_manifest.stat.exists"}},
                ]
            )
        )
        (role / "handlers/main.yml").write_text(
            yaml.safe_dump(
                [
                    {
                        "name": "Generate manifest",
                        "ansible.builtin.copy": {
                            "content": "manifest",
                            "dest": str(self.base / "Manifest"),
                            "mode": "0644",
                        },
                    }
                ]
            )
        )
        entry = [{"ansible.builtin.include_role": {"name": "portage_order"}}]
        variables = {
            "portage_distdir": str(self.base / "distfiles"),
            "ansible_facts": {"processor_vcpus": 2},
        }
        self.play(entry, variables)
        output = self.play(entry, variables)
        self.assertRegex(output, r"changed=0\b")
        self.assertIn(
            f'DISTDIR="{self.base}/distfiles"', (self.base / "make.conf").read_text()
        )


class StorageTest(AnsibleFixture):
    def setUp(self):
        super().setUp()
        self.source = self.base / "original images"
        self.target = self.base / "new images"
        self.source.mkdir()
        (self.source / "disk.img").write_bytes(b"original image contents")

    def migrate(self, success=True, fail_link=False):
        task_path = ROLES / "migrate_storage/tasks/kvm-data.yml"
        if fail_link:
            tasks = yaml.safe_load(task_path.read_text())
            switch = next(
                t
                for t in tasks
                if t["name"] == "Switch to the new storage with rollback"
            )
            # Inject a failure after link creation, as could happen if subsequent
            # metadata work fails. All copy/rename/link/rollback actions remain real.
            switch["block"][-1]["failed_when"] = True
            task_path = self.base / "fault.yml"
            task_path.write_text(yaml.safe_dump(tasks))
        return self.play(
            [
                {
                    "ansible.builtin.stat": {"path": str(self.source), "follow": False},
                    "register": "test_source",
                },
                {
                    "ansible.builtin.include_tasks": str(task_path),
                    "when": "test_source.stat.isdir | default(false)",
                },
            ],
            {
                "migrate_storage_kvm_source_dir": str(self.source),
                "migrate_storage_kvm_target_dir": str(self.target),
            },
            success=success,
        )

    def test_copy_retains_backup_and_repeat_run_changes_nothing(self):
        self.migrate()
        self.assertTrue(self.source.is_symlink())
        self.assertEqual(self.source.resolve(), self.target)
        backup = Path(str(self.source) + ".pre-migration")
        self.assertEqual(
            (backup / "disk.img").read_bytes(), (self.target / "disk.img").read_bytes()
        )
        self.assertRegex(self.migrate(), r"changed=0\b")

    def test_checksum_detects_corruption_with_matching_size_and_timestamp(self):
        self.target.mkdir()
        original = self.source / "disk.img"
        corrupt = self.target / "disk.img"
        corrupt.write_bytes(b"x" * original.stat().st_size)
        shutil.copystat(original, corrupt)
        self.migrate(success=False)
        self.assertFalse(self.source.is_symlink())
        self.assertEqual(original.read_bytes(), b"original image contents")
        self.assertFalse(Path(str(self.source) + ".pre-migration").exists())

    def test_copy_failure_restores_the_previous_service_state(self):
        self.target.mkdir()
        (self.target / "disk.img").write_bytes(b"conflicting destination")
        state_file = self.base / "service-state"
        role = self.base / "roles/service_recovery"
        (role / "tasks").mkdir(parents=True)
        shutil.copy(
            ROLES / "migrate_storage/tasks/kvm-data.yml", role / "tasks/kvm-data.yml"
        )

        # Replace only libvirt I/O. Ansible executes the production block/always
        # structure and the actual failing filesystem transaction.
        def mock_services(tasks, initial_state):
            for task in tasks:
                if "ansible.builtin.service_facts" in task:
                    del task["ansible.builtin.service_facts"]
                    task["ansible.builtin.set_fact"] = {
                        "ansible_facts": {
                            "services": {"libvirtd.service": {"state": initial_state}}
                        }
                    }
                if "ansible.builtin.service" in task:
                    service = task.pop("ansible.builtin.service")
                    task["ansible.builtin.copy"] = {
                        "content": service["state"],
                        "dest": str(state_file),
                        "mode": "0644",
                    }
                if str(task.get("ansible.builtin.command", "")).startswith("virsh "):
                    task["ansible.builtin.command"] = {
                        "argv": [sys.executable, "-c", "pass"]
                    }
                for section in ("block", "rescue", "always"):
                    mock_services(task.get(section, []), initial_state)

        for initial_state in ("running", "stopped"):
            with self.subTest(initial_state=initial_state):
                tasks = yaml.safe_load(
                    (ROLES / "migrate_storage/tasks/kvm.yml").read_text()
                )
                mock_services(tasks, initial_state)
                (role / "tasks/main.yml").write_text(yaml.safe_dump(tasks))
                self.play(
                    [{"ansible.builtin.include_role": {"name": "service_recovery"}}],
                    {
                        "migrate_storage_libvirt_service": "libvirtd",
                        "migrate_storage_kvm_source_dir": str(self.source),
                        "migrate_storage_kvm_target_dir": str(self.target),
                    },
                    success=False,
                )
                self.assertEqual(
                    state_file.read_text(),
                    "started" if initial_state == "running" else "stopped",
                )
                self.assertFalse(self.source.is_symlink())
                self.assertEqual(
                    (self.source / "disk.img").read_bytes(), b"original image contents"
                )

    def test_failed_switch_restores_original_directory(self):
        self.migrate(success=False, fail_link=True)
        self.assertFalse(self.source.is_symlink())
        self.assertEqual(
            (self.source / "disk.img").read_bytes(), b"original image contents"
        )
        self.assertFalse(Path(str(self.source) + ".pre-migration").exists())


if __name__ == "__main__":
    unittest.main()
