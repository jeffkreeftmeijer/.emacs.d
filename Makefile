build:
	nix build --print-build-logs --file configured-emacs.nix

open:
	open result/Applications/Emacs.app

update_patches:
	curl https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-30/system-appearance.patch -O
