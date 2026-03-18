RAILWAY_PROJECT ?= templates-test
SECRET_KEY ?= $(shell openssl rand -hex 32)
ADMIN_PASSWORD ?= $(shell openssl rand -hex 16)

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --service SearXNG
	railway up app --path-as-root --service SearXNG
	railway variable set --service SearXNG \
	  SEARXNG_SECRET_KEY=$(SECRET_KEY) \
	  SEARXNG_ADMIN_PASSWORD=$(ADMIN_PASSWORD)

destroy:
	@echo "Delete services via Railway dashboard: SearXNG"
	@echo "https://railway.app/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service SearXNG --lines 100

.PHONY: deploy destroy status logs
