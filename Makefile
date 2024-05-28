build:
	nix build --print-build-logs .#configured-emacs

open:
	open result/Applications/Emacs.app

update:
	nix flake lock --update-input emacs-overlay

update_patches:
	curl https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-30/system-appearance.patch -O
