.PHONY: start stop logs

start: ## Pull images and start the stack
	docker compose pull
	docker compose up --detach

stop: ## Stop the stack (data is kept)
	docker compose down

logs: ## Follow logs from all services
	docker compose logs --follow
