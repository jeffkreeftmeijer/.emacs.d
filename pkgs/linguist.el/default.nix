{lib, fetchFromGitHub, trivialBuild, ...}:

trivialBuild {
  pname = "linguist";

  src = fetchFromGitHub {
    owner = "jeffkreeftmeijer";
    repo = "linguist.el";
    rev = "849455da4d64fd777993515b91a54cfbdb4c7b15";
    sha256 = "sha256-mzAzEmiVp2vACqCY3OGWCwYG4p9crHVFoaVaVUAwvro=";
  };

  packageRequires = [
    # dockerfile-mode
    # elixir-mode
    # git-modes
    # ledger-mode
    # markdown-mode
    # nix-mode
    # yaml-mode
  ];
}
