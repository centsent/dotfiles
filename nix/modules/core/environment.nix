{ pkgs, ... }:

let
  # Dynamically set ANDROID_HOME based on the OS
  androidHome = if pkgs.stdenv.isDarwin then
    "$HOME/Library/Android/Sdk"
  else
    "$HOME/Android/Sdk";
in {
  # --- Environment Variables ---
  home.sessionVariables = {
    BUN_INSTALL = "$HOME/.bun";
    GOPATH = "$HOME/go";
    ANDROID_HOME = androidHome;
  };

  # --- PATH Modifications ---
  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/go/bin"
    "$HOME/.pub-cache/bin"
    "$HOME/.config/emacs/bin"
    "${androidHome}/platform-tools"
    "${androidHome}/tools"
    "${androidHome}/tools/bin"
    "${androidHome}/emulator"
  ];
}
