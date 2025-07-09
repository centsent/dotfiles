{ ... }:

{
  services.flatpak.enable = true;

  services.flatpak.packages = [
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
}
