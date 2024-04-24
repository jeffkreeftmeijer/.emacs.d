{ pkgs ? import <nixpkgs> {
  overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/f7fcac1403356fd09e2320bc3d61ccefe36c1b91.tar.gz;
    }))
  ];
} }:

pkgs.emacsWithPackagesFromUsePackage {
  package = (
    pkgs.emacs-git.overrideAttrs(old: {
      patches = old.patches ++ [
        ./patches/system-appearance.patch
        ./patches/round-undecorated-frame.patch
        ./patches/poll.patch
        ./patches/fix-window-role.patch
      ];
    })
  );

  config = ./default.el;
  defaultInitFile = true;
}
