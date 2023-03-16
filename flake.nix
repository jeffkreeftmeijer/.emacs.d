{
  description = "Configured Emacs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, emacs-overlay }:
  let
    system = "x86_64-darwin";
    pkgs = (import nixpkgs {
      inherit system;
      overlays = [ self.overlay ];
    }).extend(emacs-overlay.overlay);
  in {
    overlay = (final: prev: rec {
      configured-emacs = pkgs.emacsGit-nox;
    });

    packages.x86_64-darwin = pkgs;
  };
}
