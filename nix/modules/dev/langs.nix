{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    cabal-install
    dotnet-sdk
    gcc
    gdb
    ghc
    gnumake
    go
    luajit
    jdk
    nodejs
    pnpm
    python3
    ruby
    rustup
  ];
}
