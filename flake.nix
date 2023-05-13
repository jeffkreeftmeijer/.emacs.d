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
      overlays = [ emacs-overlay.overlay self.overlay ];
    });
  in {
    overlay = (final: prev: rec {
      configured-emacs = (pkgs.emacsWithPackagesFromUsePackage {
        config = ./default.el;
        defaultInitFile = true;
        package = pkgs.emacsGit.override {
          treeSitterPlugins = with pkgs.tree-sitter-grammars; [
            tree-sitter-elixir
            tree-sitter-heex
          ];
        };
        extraEmacsPackages = epkgs: [
          pkgs.callPackage pkgs/linguist.el {}
        ];
      });
    });

    packages.x86_64-darwin = pkgs;
  };
}
