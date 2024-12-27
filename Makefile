export DOTFILES_DIR=$(shell pwd)

.PHONY: all
all: install symlink

.PHONY: install
install: ## Install essential tools
	@echo '==> Start to install app using pkg manager.'
	@bash ${DOTFILES_DIR}/etc/install.sh

.PHONY: symlink
symlink: ## Create symlink for dotfiles
	@echo '==> Start to create symbolic links for dotfiles.'
	@bash ${DOTFILES_DIR}/etc/symlink.sh

.PHONY: test
test:
	@echo ${DOTFILES_DIR}

clean-backup: ## Remove backup files
	@echo '==> Start to remove backup files.'
	rm -rf ${DOTFILES_DIR}/tmp/backup

.PHONY: help
help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
