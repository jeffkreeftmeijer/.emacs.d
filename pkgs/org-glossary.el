{lib , fetchFromGitHub , trivialBuild , emacs}:

trivialBuild {
  pname = "org-glossary";

  src = fetchFromGitHub {
    owner = "tecosaur";
    repo = "org-glossary";
    rev = "1b9b7fd3d1e6c214c34463e568daaba6df00ec27";
    sha256 = "sha256-Q/H3QpYQHP6VMfh8YXomdXLhODlg+nYn6t1W1bFCryY=";
  };
}
