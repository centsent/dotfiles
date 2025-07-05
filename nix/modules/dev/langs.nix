{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    cabal-install
    dotnet-sdk
    flutter
    gcc
    gdb
    ghc
    gnumake
    go
    lua
    jdk
    nodejs
    pnpm
    python3
    ruby
    rustup
  ];
}
