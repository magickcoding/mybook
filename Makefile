THIS_MAKEFILE_PATH := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_DIR := $(shell cd $(dir $(THIS_MAKEFILE_PATH));pwd)

NPM ?= $(NODE) $(shell which npm)
ELECTRON_BIN = $(shell which electron)

RED=`tput setaf 1`

START_APP := @$(ELECTRON_BIN) .

NPMGTE3 := $(shell expr `npm -v | cut -f1 -d.` \>= 3)

run:
	$(START_APP)
# NPM
install: node_modules
	@if [ ! "$(NPMGTE3)" = "1" ]; then echo "$(RED)Requires npm >= 3, upgrade npm and delete both node_modules and retry$(RESET)"; exit 1; fi

node_modules/%:
	@$(NPM) install $(notdir $@)

node_modules: package.json
	@$(NPM) prune
	@$(NPM) install
	@touch node_modules

.PHONY: run
