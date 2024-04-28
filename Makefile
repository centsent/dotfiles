.PHONY: install
install:
	ansible-playbook -i ./hosts ./dotfiles.yml

gentoo:
	ansible-playbook -i ./hosts ./dotfiles.yml --tags gentoo
	

macos:
	ansible-playbook -i ./hosts ./dotfiles.yml --tags macos
