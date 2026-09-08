"""Check effective host behavior without building or activating a generation."""

import json
from pathlib import Path
import subprocess
import unittest


class HomeConfigurationsTest(unittest.TestCase):
    def test_hosts_provide_bootstrap_tools_without_network_activation_hooks(self):
        for host in ("gentoo", "macosx"):
            with self.subTest(host=host):
                config = json.loads(
                    subprocess.check_output(
                        [
                            "bash",
                            str(Path(__file__).resolve().parents[2] / "scripts/nix.sh"),
                            "eval",
                            "--no-write-lock-file",
                            "--json",
                            f".#homeConfigurations.{host}.config",
                            "--apply",
                            """c: {
                      homeManager = c.programs.home-manager.enable;
                      mise = c.programs.mise.enable;
                      miseTarget = c.xdg.configFile."mise".target;
                      miseSource = c.xdg.configFile."mise".source;
                      intelDarwinAcknowledged = c.nixpkgs.config.allowDeprecatedx86_64Darwin;
                      shell = c.programs.zsh.initContent;
                      activation = builtins.mapAttrs (_: action: action.data) c.home.activation;
                      packages = map (p: p.pname or p.name) c.home.packages;
                      tmuxPlugins = builtins.length c.programs.tmux.plugins;
                      tmuxConfig = c.xdg.configFile."tmux/tmux.conf".enable;
                      stateVersion = c.home.stateVersion;
                      derivation = c.home.activationPackage.drvPath;
                    }""",
                        ],
                        cwd=Path(__file__).resolve().parents[1],
                        text=True,
                    )
                )
                self.assertTrue(config["homeManager"])
                self.assertTrue(config["mise"])
                self.assertEqual(config["miseTarget"], ".config/mise")
                self.assertTrue(config["miseSource"].endswith("/.config/mise"))
                self.assertEqual(config["intelDarwinAcknowledged"], host == "macosx")
                self.assertIn("/bin/mise activate zsh", config["shell"])
                self.assertNotIn("$HOME/.local/bin/mise", config["shell"])
                self.assertIn("dotfiles-tools-sync", config["packages"])
                self.assertIn("dotfiles-doom-sync", config["packages"])
                for script in config["activation"].values():
                    for command in (
                        "mise install",
                        "mise.run",
                        "DOOM_EXEC",
                        "doom sync",
                    ):
                        self.assertNotIn(command, script)
                self.assertEqual(config["tmuxPlugins"], 0)
                self.assertTrue(config["tmuxConfig"])
                self.assertEqual(config["stateVersion"], "25.05")
                self.assertTrue(config["derivation"].endswith(".drv"))


if __name__ == "__main__":
    unittest.main()
