{ pkgs ? import <nixpkgs> {
  overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
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

      buildInputs = old.buildInputs ++ [
        pkgs.darwin.apple_sdk.frameworks.WebKit
      ];

      configureFlags = old.configureFlags ++ ["--with-xwidgets"];
    })
  );

  config = ./default.el;
  defaultInitFile = true;
}
