{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    dotnet-sdk
    flutter
    gcc
    gdb
    gnumake
    go
    lua
    nodejs
    pnpm
    python3
    rustup
  ];
}
