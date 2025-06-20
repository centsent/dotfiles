#!/usr/bin/make
INVENTORY ?=

ifeq ($(shell uname -s),Darwin)
    INVENTORY = hosts_macos
endif

ifeq ($(INVENTORY),)
    ifneq ($(shell grep -q '^ID=arch' /etc/os-release && echo true),)
        INVENTORY = hosts_archlinux
    else ifneq ($(shell grep -q '^ID=gentoo' /etc/os-release && echo true),)
        INVENTORY = hosts_gentoo
    endif
endif

.PHONY: deps
deps:
	@echo "==> Installing Ansible Galaxy role dependencies..."
	ansible-galaxy install -r requirements.yml

.PHONY: install all
all: install
install:
	ansible-playbook -i $(INVENTORY) ./dotfiles.yml

.PHONY: macos
macos: deps
	ansible-playbook -i $(INVENTORY) ./macos.yml --ask-become-pass

.PHONY: gentoo
gentoo: deps
	ansible-playbook -i $(INVENTORY) ./gentoo.yml

.PHONY: update
update:
	ansible-playbook -i $(INVENTORY) ./update.yml

.PHONY: archlinux
archlinux: deps
	ansible-playbook -i $(INVENTORY) ./archlinux.yml

.PHONY: run
TAGS ?= all
run: deps
	ansible-playbook -i $(INVENTORY) ./dotfiles.yml --tags "$(TAGS)"

%:
	@make run TAGS=$@
