{ username, ... }:
{
  home.homeDirectory = "/home/${username}";
  imports = [
    ./common.nix
    ../modules/apps/linux-apps.nix
  ];
}
