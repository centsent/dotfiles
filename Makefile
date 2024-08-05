.PHONY: install
install:
	ansible-playbook -i ./hosts ./dotfiles.yml

.PHONY: macos
macos:
	ansible-playbook -i ./hosts ./dotfiles.yml --tags macos --ask-become-pass

%:
	ansible-playbook -i ./hosts ./dotfiles.yml --tags $@
