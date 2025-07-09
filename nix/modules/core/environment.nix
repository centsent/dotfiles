{ pkgs, ... }:

{
  # --- Environment Variables ---
  home.sessionVariables = {
    BUN_INSTALL = "$HOME/.bun";
    GOPATH = "$HOME/go";

    # Dynamically set ANDROID_HOME based on the OS
    ANDROID_HOME = if pkgs.stdenv.isDarwin then "$HOME/Library/Android/Sdk" else "$HOME/Android/Sdk";
  };

  # --- PATH Modifications ---
  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/go/bin"
    "$HOME/.pub-cache/bin"
    "$ANDROID_HOME/platform-tools"
    "$ANDROID_HOME/tools"
    "$ANDROID_HOME/tools/bin"
    "$ANDROID_HOME/emulator"
  ];
}
