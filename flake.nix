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

        package = pkgs.emacsGit.overrideAttrs (old: {
          buildInputs = old.buildInputs ++ [ pkgs.elixir-ls ];
        }).override {
          treeSitterPlugins = with pkgs.tree-sitter-grammars; [
            tree-sitter-elixir
            tree-sitter-heex
          ];
        };
        extraEmacsPackages = epkgs: [
          epkgs.dockerfile-mode
          epkgs.elixir-mode
          epkgs.git-modes
          epkgs.ledger-mode
          epkgs.markdown-mode
          epkgs.nix-mode
          epkgs.yaml-mode
        ];

        override = epkgs: epkgs // {
          linguist = pkgs.callPackage ../pkgs/linguist.el {
            trivialBuild = epkgs.trivialBuild;
          };
        };
      });
    });

    packages.x86_64-darwin = pkgs;
  };
}
