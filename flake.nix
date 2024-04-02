{
  outputs = { self, nixpkgs }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShell."${system}" = pkgs.mkShell {
      buildInputs = [
        pkgs.pre-commit
      ];
      shellHook = "pre-commit install > /dev/null";
    };
  };
}
