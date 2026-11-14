.PHONY: start stop logs start-local rebuild-local check-siblings vendor-server

LOCAL := docker compose -f compose.yaml -f compose.local.yaml
SIBLINGS := ../budget-server ../budget

start: ## Pull images and start the stack
	docker compose pull
	docker compose up --detach

stop: ## Stop the stack (data is kept)
	docker compose down

logs: ## Follow logs from all services
	docker compose logs --follow

start-local: vendor-server ## Build budget-server and web from sibling checkouts and start the stack
	$(LOCAL) build
	$(LOCAL) up --detach

rebuild-local: check-siblings ## Rebuild and restart one local service: make rebuild-local s=budget-server
	@test -n "$(s)" || { echo "usage: make rebuild-local s=<budget-server|web>"; exit 1; }
	@if [ "$(s)" = budget-server ]; then $(MAKE) --no-print-directory vendor-server; fi
	$(LOCAL) up --detach --build --no-deps $(s)

check-siblings:
	@for dir in $(SIBLINGS); do \
		test -d "$$dir" || { echo "missing sibling checkout: $$dir (clone it next to budget-stack)"; exit 1; }; \
	done

# The budget-server image builds with -mod=vendor and vendor/ is gitignored.
vendor-server: check-siblings
	cd ../budget-server && go mod vendor
