export dotfiles=${HOME}/dotfiles

deploy: ## Create symlink
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	bash ${dotfiles}/etc/deploy

init: ## Setup environment settings
	@echo '==> Start to install app using pkg manager.'
	@echo ''
	bash ${dotfiles}/etc/init

update: ## Fetch changes for this repo
	git pull origin master

install: update deploy init
	@exec $$SHELL -l

test:
	@echo ${dotfiles}

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
