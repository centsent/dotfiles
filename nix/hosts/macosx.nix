{ username, ... }:
{
  home.homeDirectory = "/Users/${username}";
  imports = [
    ./common.nix
    ../modules/apps/macos-apps.nix
  ];
}
