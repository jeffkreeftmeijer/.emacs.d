{
  outputs = { self, nixpkgs }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.callPackage ./configured-emacs.nix {};

    devShell."${system}" = pkgs.mkShell {
      buildInputs = [
        pkgs.pre-commit
      ];
      shellHook = "pre-commit install > /dev/null";
    };
  };
}
