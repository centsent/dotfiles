{ pkgs, ... }:

let
  flatpakApps = [
    "com.bitwarden.desktop"
    "com.github.tchx84.Flatseal"
    "com.synology.SynologyDrive"
    "com.tencent.WeChat"
    "io.beekeeperstudio.Studio"
    "org.gnome.Calendar"
    "org.kde.dolphin"
    "org.jupyter.JupyterLab"
    "rest.insomnia.Insomnia"
  ];
in
{
  home.packages = [ pkgs.flatpak ];

  home.activation = {
    installFlatpakApps = pkgs.lib.hm.dag.entryAfter ["writeBoundary"] ''
      # The 'pkgs.lib.escapeShellArg' is used for security and correctness.
      # This command will install all apps from the list above.
      ${pkgs.flatpak}/bin/flatpak install --user --noninteractive -y \
        ${builtins.concatStringsSep " " (map (x: pkgs.lib.escapeShellArg x) flatpakApps)}
    '';
  };
}
