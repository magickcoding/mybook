THIS_MAKEFILE_PATH := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_DIR := $(shell cd $(dir $(THIS_MAKEFILE_PATH));pwd)

NPM ?= $(NODE) $(shell which npm)
NPM_BIN = $(shell npm bin)
WEBPACK_BIN := $(NPM_BIN)/webpack
ELECTRON_BIN = $(NPM_BIN)/electron

RED=`tput setaf 1`
RESET=`tput sgr0`

START_APP := @$(ELECTRON_BIN) .

NPMGTE3 := $(shell expr `npm -v | cut -f1 -d.` \>= 3)

run: build
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

build: install
	@echo "begin to build"
	@$(WEBPACK_BIN)

test:
	@$(WEBPACK_BIN) --display-error-details

.PHONY: run
