.PHONY: start start-local stop logs

ALL := docker compose --profile release --profile local

start: ## Pull the pinned releases and start the stack
	$(ALL) stop budget-server-local web-local
	docker compose --profile release pull
	docker compose --profile release up --detach

start-local: ## Build budget-server and web from ../budget-server and ../budget and start the stack; rerun after changes
	$(ALL) stop budget-server web
	docker compose --profile local up --detach --build

stop: ## Stop the stack (data is kept)
	$(ALL) down

logs: ## Follow logs from all services
	$(ALL) logs --follow
