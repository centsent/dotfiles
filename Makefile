.PHONY: common
common:
	stow --verbose --target $(HOME) --restow common

.PHONY: linux
linux: common
	stow --verbose --target $(HOME) --restow linux

.PHONY: mac
mac: common
	stow --verbose --target $(HOME) --restow mac

.PHONY: delete
delete:
	stow --verbose --delete */
