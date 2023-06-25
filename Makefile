.PHONY: mac
mac:
	nix run home-manager switch -- --flake .\#theodo
	nix-collect-garbage

.PHONY: wsl
wsl:
	nix run home-manager switch -- --flake .\#mafioso
	nix-collect-garbage


.PHONY: gc
gc:
	nix-collect-garbage

.PHONY: common
common:
	stow --verbose --target $(HOME) --restow common

.PHONY: linux
linux: common
	stow --verbose --target $(HOME) --restow linux

.PHONY: delete
delete:
	stow --verbose --delete */
