{ ... }:

{
  xdg.desktopEntries = {
    "android-studio" = {
      name = "Android Studio";
      comment = "Android development environment based on IntelliJ IDEA";
      exec = "android-studio";
      icon = "android-studio";
      terminal = false;
      categories = [ "Development" "IDE" ];
      startupWMClass = "jetbrains-studio";
    };

    "obsidian" = {
      name = "Obsidian";
      comment = "Obsidian with Wayland support enabled";
      exec = "obsidian --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations --enable-wayland-ime %F";
      icon = "obsidian";
      terminal = false;
      categories = [ "Office" ];
      mimeType = [ "x-scheme-handler/obsidian" ];
      startupWMClass = "obsidian";
    };
  };

  home.sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
}
