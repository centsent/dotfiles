"""Exercise the evaluated Nix aliases in Zsh with real temporary Git repositories.

Run with: python3 nix/tests/test_zsh_aliases.py
Requires nix, zsh, and git. The agy executable is mocked; no AI requests are made.
"""

import json
import os
from pathlib import Path
import shlex
import subprocess
import sys
import tempfile
import unittest


class GitAliasesTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        nix_dir = Path(__file__).resolve().parents[1]
        config = json.loads(subprocess.check_output([
            "nix", "eval", "--impure", "--json", "--expr",
            "(import ./modules/core/zsh-aliases.nix {}).programs.zsh",
        ], cwd=nix_dir, text=True))
        cls.source = "\n".join(
            f"alias {name}={shlex.quote(value)}"
            for name, value in config.get("shellAliases", {}).items()
        ) + "\n" + config.get("initContent", "") + "\n"

    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="zsh-aliases-")
        self.addCleanup(self.temp.cleanup)
        self.base = Path(self.temp.name).resolve()
        self.repo = self.base / "repo with spaces and 'quotes'"
        self.nested = self.repo / "nested"
        self.nested.mkdir(parents=True)
        self.calls = self.base / "calls.jsonl"
        mock_bin = self.base / "bin"
        mock_bin.mkdir()
        agy = mock_bin / "agy"
        agy.write_text(
            f"#!{sys.executable}\n"
            "import json, os, sys\n"
            "with open(os.environ['AGY_TEST_CALLS'], 'a') as calls:\n"
            "    calls.write(json.dumps({'cwd': os.getcwd(), 'args': sys.argv[1:]}) + '\\n')\n"
            "sys.exit(int(os.environ.get('AGY_TEST_EXIT', '0')))\n"
        )
        agy.chmod(0o755)
        self.env = {
            key: value for key, value in os.environ.items()
            if not key.startswith("GIT_")
        }
        self.env.update(
            PATH=str(mock_bin) + os.pathsep + os.environ["PATH"],
            AGY_TEST_CALLS=str(self.calls),
            GIT_CONFIG_NOSYSTEM="1",
            GIT_CONFIG_GLOBAL=os.devnull,
        )
        self.git("init", "-q")

    def git(self, *args):
        return subprocess.check_output(
            ["git", "-C", str(self.repo), *args], env=self.env, text=True,
        )

    def run_alias(self, script, cwd=None, **env):
        script_file = self.base / "invocation.zsh"
        script_file.write_text(self.source + script + "\n")
        return subprocess.run(
            ["zsh", "-f", str(script_file)],
            cwd=cwd or self.nested, env={**self.env, **env},
            text=True, capture_output=True,
        )

    def read_calls(self):
        if not self.calls.exists():
            return []
        return [json.loads(line) for line in self.calls.read_text().splitlines()]

    def test_nested_directory_and_argument_forwarding(self):
        for name in ("aic", "aim"):
            with self.subTest(alias=name):
                result = self.run_alias(
                    f'{name} --model "test model"\nprintf "%s" "$PWD"'
                )
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stdout, str(self.nested))
                self.assertTrue(self.read_calls(), result.stderr)
                call = self.read_calls()[-1]
                self.assertEqual(call["cwd"], str(self.repo))
                self.assertEqual(call["args"][:3], ["--add-dir", str(self.repo), "--prompt"])
                self.assertIn(str(self.repo), call["args"][3])
                self.assertEqual(call["args"][4:], ["--model", "test model"])

    def test_non_repository_does_not_launch_agent(self):
        for name in ("aic", "aim"):
            with self.subTest(alias=name):
                result = self.run_alias(name, cwd=self.base)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(self.read_calls(), [])

    def test_agent_failure_is_returned(self):
        for name in ("aic", "aim"):
            with self.subTest(alias=name):
                result = self.run_alias(name, AGY_TEST_EXIT="37")
                self.assertEqual(result.returncode, 37, result.stderr)

    def test_grouped_commits_reject_existing_index_without_changing_it(self):
        (self.repo / "staged.txt").write_text("already staged\n")
        self.git("add", "staged.txt")
        (self.repo / "staged.txt").write_text("additional unstaged changes\n")
        (self.repo / "untracked.txt").write_text("untracked\n")
        before = [self.git(*args) for args in (
            ("status", "--porcelain"), ("diff",), ("diff", "--cached"),
        )]
        result = self.run_alias("aim")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("staged changes", result.stderr)
        self.assertEqual(self.read_calls(), [])
        after = [self.git(*args) for args in (
            ("status", "--porcelain"), ("diff",), ("diff", "--cached"),
        )]
        self.assertEqual(before, after)

    def test_single_commit_accepts_existing_index(self):
        (self.repo / "staged.txt").write_text("already staged\n")
        self.git("add", "staged.txt")
        result = self.run_alias("aic")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(len(self.read_calls()), 1)

    def test_linked_worktree_uses_its_own_root(self):
        self.git("-c", "user.name=Test", "-c", "user.email=test@example.invalid",
                 "commit", "--allow-empty", "-qm", "Initial commit")
        worktree = self.base / "linked worktree"
        self.git("worktree", "add", "-qb", "test-worktree", str(worktree))
        nested = worktree / "nested"
        nested.mkdir()
        for name in ("aic", "aim"):
            with self.subTest(alias=name):
                result = self.run_alias(name, cwd=nested)
                self.assertEqual(result.returncode, 0, result.stderr)
                call = self.read_calls()[-1]
                self.assertEqual(call["cwd"], str(worktree))
                self.assertEqual(call["args"][1], str(worktree))


if __name__ == "__main__":
    unittest.main()
