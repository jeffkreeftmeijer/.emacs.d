{ lib, fetchFromGitea, trivialBuild, elixir-mode, ...}:

trivialBuild {
  pname = "linguist";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "jkreeftmeijer";
    repo = "linguist.el";
    rev = "275182957c345bd2d88cee30633c14cace7e56e6";
    sha256 = "sha256-NRk9tM0U6junhgK/P0yb0haMzkm5IVWMgAa48KTspoQ=";
  };

  packageRequires = [ elixir-mode ];
}
