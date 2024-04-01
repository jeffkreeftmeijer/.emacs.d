{
  outputs = { self, nixpkgs }: let
    system = "aarch64-darwin";
  in {
    devShell."${system}" = let
      pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell {
      buildInputs = [
        pkgs.pre-commit
      ];
      shellHook = "pre-commit install > /dev/null";
    };
  };
}
