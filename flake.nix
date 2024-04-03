{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { inherit system; };
    configured-emacs = pkgs.callPackage ./configured-emacs.nix {};
  in {
    packages.configured-emacs = configured-emacs;
    packages.default = configured-emacs;

    devShell = pkgs.mkShell {
      buildInputs = [pkgs.pre-commit];
      shellHook = "pre-commit install > /dev/null";
    };
  });
}
