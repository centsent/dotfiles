#!/usr/bin/make

ANSIBLE_DIR := ansible

INVENTORY_FILE ?=

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
    INVENTORY_FILE = hosts_macos
else
    ifneq ($(shell grep -q '^ID=arch' /etc/os-release && echo true),)
        INVENTORY_FILE = hosts_archlinux
    else ifneq ($(shell grep -q '^ID=gentoo' /etc/os-release && echo true),)
        INVENTORY_FILE = hosts_gentoo
    endif
endif

INVENTORY = $(ANSIBLE_DIR)/$(INVENTORY_FILE)

.PHONY: install all
all: install
install:
	@echo "==> Running main installation playbook..."
	ansible-playbook -i $(INVENTORY) $(ANSIBLE_DIR)/dotfiles.yml --ask-become-pass

# Specific playbook targets
.PHONY: macos
macos:
	ansible-playbook -i $(INVENTORY) $(ANSIBLE_DIR)/macos.yml --ask-become-pass

.PHONY: gentoo
gentoo:
	ansible-playbook -i $(INVENTORY) $(ANSIBLE_DIR)/gentoo.yml

.PHONY: archlinux
archlinux:
	ansible-playbook -i $(INVENTORY) $(ANSIBLE_DIR)/archlinux.yml

# Target for running specific tags
.PHONY: run
TAGS ?= all
run:
	ansible-playbook -i $(INVENTORY) $(ANSIBLE_DIR)/dotfiles.yml --tags "$(TAGS)" --ask-become-pass

%:
	@make run TAGS=$@
