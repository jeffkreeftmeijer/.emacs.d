{ pkgs ? import <nixpkgs> {
  overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/f7fcac1403356fd09e2320bc3d61ccefe36c1b91.tar.gz;
    }))
  ];
} }:

pkgs.emacsWithPackagesFromUsePackage {
  config = ./default.el;
  defaultInitFile = true;
}
