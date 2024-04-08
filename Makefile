build:
	nix build --print-build-logs --file configured-emacs.nix

open:
	open result/Applications/Emacs.app
