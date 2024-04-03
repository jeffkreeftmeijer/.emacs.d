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
  in {
    packages.default = pkgs.callPackage ./configured-emacs.nix {};

    devShell = pkgs.mkShell {
      buildInputs = [pkgs.pre-commit];
      shellHook = "pre-commit install > /dev/null";
    };
  });
}
