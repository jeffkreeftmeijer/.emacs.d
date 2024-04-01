{ pkgs ? import <nixpkgs> {} }:

let
  epkgs = pkgs.emacsPackages;
  emacsWithPackages = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages;

  default = epkgs.trivialBuild {
    pname = "default";
    src = pkgs.writeText "default.el" (builtins.readFile ./default.el);
    version = "0.1.0";
  };
in
emacsWithPackages [
  epkgs.modus-themes
  epkgs.spacious-padding
  epkgs.magit
  epkgs.evil
  epkgs.evil-collection
  epkgs.evil-commentary
  default
]
