.PHONY: start start-local stop logs

ALL := docker compose --profile release --profile local

start: ## Pull the pinned releases and start the stack
	$(ALL) stop budget-server-local web-local
	docker compose --profile release pull
	docker compose --profile release up --detach

# budget-server's image builds from a vendor/ directory it doesn't commit.
start-local: ## Build budget-server and web from ../budget-server and ../budget and start the stack; rerun after changes
	$(ALL) stop budget-server web
	docker run --rm -u "$$(id -u):$$(id -g)" -e GOPATH=/tmp/go -e GOCACHE=/tmp/go-cache \
		-v "$(abspath ../budget-server)":/src -w /src golang:1.27-alpine go mod vendor
	docker compose --profile local up --detach --build

stop: ## Stop the stack (data is kept)
	$(ALL) down

logs: ## Follow logs from all services
	$(ALL) logs --follow
