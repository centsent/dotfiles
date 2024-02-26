.PHONY: install
install:
	ansible-playbook -i ./hosts ./dotfiles.yml --ask-become-pass
