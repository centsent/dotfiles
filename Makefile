#!/usr/bin/make

ANSIBLE_DIR := ansible

INVENTORY_FILE ?=

UNAME_S := $(shell uname -s)

SECRETS_FILE := ansible/group_vars/all/secrets.sops.yaml

# Sourced rather than grepped: os-release quotes its values ("ID='gentoo'" on
# this host), so a literal '^ID=gentoo' match silently never fired.
ifeq ($(UNAME_S),Darwin)
    INVENTORY_FILE = hosts_macos
else ifneq ($(shell . /etc/os-release 2>/dev/null && [ "$$ID" = gentoo ] && echo true),)
    INVENTORY_FILE = hosts_gentoo
endif

INVENTORY = $(ANSIBLE_DIR)/$(INVENTORY_FILE)

# Detection failing used to leave INVENTORY_FILE empty, which quietly handed
# ansible `-i ansible/` instead of an inventory. Fail loudly instead.
.PHONY: check-inventory
check-inventory:
	@test -n "$(INVENTORY_FILE)" || { \
	  echo "ERROR: unrecognised host (expected macOS or Gentoo)."; \
	  echo "       Override with: make INVENTORY_FILE=hosts_gentoo <target>"; \
	  exit 1; }
	@test -f "$(INVENTORY)" || { \
	  echo "ERROR: inventory not found: $(INVENTORY)"; exit 1; }

.PHONY: install all
all: install
install: check-inventory
	@echo "==> Running main installation playbook..."
	ansible-playbook -i $(INVENTORY) $(ANSIBLE_DIR)/dotfiles.yml --ask-become-pass

.PHONY: edit
edit:
	@echo "Opening $(SECRETS_FILE) for editing..."
	@sops $(SECRETS_FILE)

# Specific playbook targets
.PHONY: macos
macos: check-inventory
	ansible-playbook -i $(INVENTORY) $(ANSIBLE_DIR)/macos.yml --ask-become-pass

.PHONY: gentoo
gentoo: check-inventory
	ansible-playbook -i $(INVENTORY) $(ANSIBLE_DIR)/gentoo.yml

# Target for running specific tags
.PHONY: run
TAGS ?= all
run: check-inventory
	ansible-playbook -i $(INVENTORY) $(ANSIBLE_DIR)/dotfiles.yml --tags "$(TAGS)" --ask-become-pass

# Any other target name is passed through to ansible as a tag, e.g. `make grub`.
%:
	@$(MAKE) run TAGS=$@
