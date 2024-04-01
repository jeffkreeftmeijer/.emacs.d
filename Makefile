build:
	nix build --file configured-emacs.nix

open:
	open result/Applications/Emacs.app
