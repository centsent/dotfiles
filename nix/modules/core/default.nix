{ ... }: {
  imports = [
    ./packages.nix
    ./ssh.nix
    ./environment.nix
    ./font.nix
    ./git.nix
    ./shell.nix
  ];
}
