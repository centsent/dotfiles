#!/usr/bin/make

ANSIBLE_DIR := ansible
.DEFAULT_GOAL := all
export ANSIBLE_CONFIG := $(abspath $(ANSIBLE_DIR)/ansible.cfg)

PYTHON ?= $(if $(wildcard .venv/bin/python),.venv/bin/python,python3)
ANSIBLE_PLAYBOOK ?= $(if $(wildcard .venv/bin/ansible-playbook),.venv/bin/ansible-playbook,ansible-playbook)
ANSIBLE_ARGS ?= --ask-become-pass

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
PLAYBOOK ?= $(if $(filter hosts_macos,$(INVENTORY_FILE)),macos.yml,$(if $(filter hosts_gentoo,$(INVENTORY_FILE)),gentoo.yml,dotfiles.yml))
HOME_CONFIGURATION ?= $(if $(filter hosts_macos,$(INVENTORY_FILE)),macosx,$(if $(filter hosts_gentoo,$(INVENTORY_FILE)),gentoo))
HOME_MANAGER_BACKUP_EXT ?= backup-$(shell date -u +%Y%m%dT%H%M%SZ)
NIX := bash "$(abspath scripts/nix.sh)"
FLAKE := $(abspath nix)

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

.PHONY: install all bootstrap home setup
all: bootstrap
bootstrap: install
	@$(MAKE) home

setup:
	python3 -m venv .venv
	.venv/bin/python -m pip install -r requirements-dev.txt
	.venv/bin/ansible-galaxy collection install -r ansible/requirements.yml -p .ansible/collections

install: check-inventory
	@echo "==> Running main installation playbook..."
	$(ANSIBLE_PLAYBOOK) -i "$(INVENTORY)" $(ANSIBLE_DIR)/$(PLAYBOOK) $(ANSIBLE_ARGS)

home: check-inventory
	@test -n "$(HOME_CONFIGURATION)" || { echo "Set HOME_CONFIGURATION for this inventory."; exit 1; }
	$(NIX) run "$(FLAKE)#home-manager" -- switch -b "$(HOME_MANAGER_BACKUP_EXT)" --flake "$(FLAKE)#$(HOME_CONFIGURATION)"

.PHONY: edit
edit:
	@echo "Opening $(SECRETS_FILE) for editing..."
	@sops $(SECRETS_FILE)

# Specific playbook targets
.PHONY: macos
macos: INVENTORY_FILE = hosts_macos
macos: check-inventory
	$(ANSIBLE_PLAYBOOK) -i "$(INVENTORY)" $(ANSIBLE_DIR)/macos.yml $(ANSIBLE_ARGS)

.PHONY: gentoo
gentoo: INVENTORY_FILE = hosts_gentoo
gentoo: check-inventory
	$(ANSIBLE_PLAYBOOK) -i "$(INVENTORY)" $(ANSIBLE_DIR)/gentoo.yml $(ANSIBLE_ARGS)

.PHONY: migrate_storage
migrate_storage: INVENTORY_FILE = hosts_gentoo
migrate_storage: check-inventory
	$(ANSIBLE_PLAYBOOK) -i "$(INVENTORY)" $(ANSIBLE_DIR)/migrate-storage.yml $(ANSIBLE_ARGS)

# Target for running specific tags
.PHONY: run
TAGS ?= all
run: check-inventory
	$(ANSIBLE_PLAYBOOK) -i "$(INVENTORY)" $(ANSIBLE_DIR)/$(PLAYBOOK) --tags "$(TAGS)" $(ANSIBLE_ARGS)

.PHONY: test check syntax
syntax:
	$(ANSIBLE_PLAYBOOK) --syntax-check -i ansible/hosts_gentoo -i ansible/hosts_macos ansible/dotfiles.yml
	$(ANSIBLE_PLAYBOOK) --syntax-check -i ansible/hosts_gentoo ansible/gentoo.yml
	$(ANSIBLE_PLAYBOOK) --syntax-check -i ansible/hosts_macos ansible/macos.yml
	$(ANSIBLE_PLAYBOOK) --syntax-check -i ansible/hosts_gentoo ansible/migrate-storage.yml

test:
	$(PYTHON) -m unittest discover -s tests -v
	$(PYTHON) -m unittest discover -s nix/tests -v

check: test syntax
	$(if $(wildcard .venv/bin/yamllint),.venv/bin/yamllint,yamllint) ansible/
	$(if $(wildcard .venv/bin/ansible-lint),.venv/bin/ansible-lint,ansible-lint) ansible/
	cd nix && $(NIX) fmt -- --check .
	$(NIX) flake check "$(FLAKE)"

# Any other target name is passed through to ansible as a tag, e.g. `make grub`.
%:
	@$(MAKE) run TAGS=$@
