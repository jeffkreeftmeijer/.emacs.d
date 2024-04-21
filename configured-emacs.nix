{ pkgs ? import <nixpkgs> {
  overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/f7fcac1403356fd09e2320bc3d61ccefe36c1b91.tar.gz;
    }))
  ];
} }:

pkgs.emacsWithPackagesFromUsePackage {
  package = (pkgs.emacs-git.overrideAttrs(old: {
    patches = old.patches ++ [
      ./system-appearance.patch
    ];
  }));

  config = ./default.el;
  defaultInitFile = true;

  extraEmacsPackages = epkgs: [
    epkgs.spacious-padding
    epkgs.magit
    epkgs.evil
    epkgs.evil-collection
    epkgs.evil-commentary
    epkgs.vertico
    epkgs.marginalia
    epkgs.consult
    epkgs.orderless
    epkgs.embark
    epkgs.direnv
    epkgs.which-key
  ];
}
