{ pkgs, ... }:

let
  android-studio-launcher =
    pkgs.writeShellScriptBin "android-studio-launcher" ''
      export _JAVA_AWT_WM_NONREPARENTING=1
      export ANDROID_HOME="$HOME/Android/Sdk"
      export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$PATH"
      exec android-studio
    '';
in {
  xdg.desktopEntries = {
    "android-studio" = {
      name = "Android Studio";
      comment = "Android development environment based on IntelliJ IDEA";
      exec = "${android-studio-launcher}/bin/android-studio-launcher";
      icon = "android-studio";
      categories = [ "Development" "IDE" ];
    };

    "obsidian-wayland" = {
      name = "Obsidian Wayland";
      comment = "Obsidian with Wayland support enabled";
      exec =
        "obsidian --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations --enable-wayland-ime %F";
      icon = "obsidian";
      terminal = false;
      mimeType = [ "x-scheme-handler/obsidian" ];
      categories = [ "Office" ];
    };

    "obsidian" = {
      name = "Obsidian";
      comment = "Obsidian";
      exec = "obsidian --ozone-platform-hint=auto --enable-wayland-ime %F";
      icon = "obsidian";
      terminal = false;
      mimeType = [ "x-scheme-handler/obsidian" ];
      categories = [ "Office" ];
    };
  };
}
