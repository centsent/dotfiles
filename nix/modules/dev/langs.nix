{ pkgs, ... }:

{
  home.packages = with pkgs; [ cabal-install gcc gdb ghc gnumake luajit ruby ];
}
