{ pkgs, ... }:

{
  home.packages = with pkgs; [ cabal-install gdb ghc gnumake luajit ruby ];
}
