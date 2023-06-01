.PHONY: help up down init-secret
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'



up: ## docker compose up
	docker compose up --build -d

down: ## down
	docker compose down

init-secret: ## Create the secret
	# check if the secret already exists
	docker secret ls | grep polr-db-password
	# ask for the password
	ifndef ENV_VAR
		@echo Warning: ENV_VAR isn\'t defined\; continue? [Y/n]
		@read line; if [ $$line = "n" ]; then echo aborting; exit 1 ; fi
	endif
	
	# store it on docker secrets run/secrets/polr-db-password
