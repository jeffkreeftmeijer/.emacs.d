{lib, fetchFromGitea, trivialBuild, ...}:

trivialBuild {
  pname = "linguist";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "jkreeftmeijer";
    repo = "linguist.el";
    rev = "849455da4d64fd777993515b91a54cfbdb4c7b15";
    sha256 = "sha256-cLbZRfav6l9slytpXIEG83dylf8HxjjXwLrnw1ICn8g=";
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
}
