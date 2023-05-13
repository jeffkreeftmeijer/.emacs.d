{lib, fetchFromGitea, trivialBuild, dockerfile-mode, ...}:

trivialBuild {
  pname = "linguist";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "jkreeftmeijer";
    repo = "linguist.el";
    rev = "849455da4d64fd777993515b91a54cfbdb4c7b15";
    sha256 = "sha256-cLbZRfav6l9slytpXIEG83dylf8HxjjXwLrnw1ICn8g=";
  };

  packageRequires = [
    dockerfile-mode
    # elixir-mode
    # git-modes
    # ledger-mode
    # markdown-mode
    # nix-mode
    # yaml-mode
  ];
}
