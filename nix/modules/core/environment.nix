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
    ANDROID_HOME = androidHome;
    BUN_INSTALL = "$HOME/.bun";
    EDITOR = "nvim";
    GOPATH = "$HOME/go";
  };

  # --- PATH Modifications ---
  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/go/bin"
    "$HOME/.pub-cache/bin"
    "${androidHome}/platform-tools"
    "${androidHome}/tools"
    "${androidHome}/tools/bin"
    "${androidHome}/emulator"
    "$HOME/.platformio/penv/bin"
  ];
}
