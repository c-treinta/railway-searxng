RAILWAY_PROJECT ?= templates-test
SECRET_KEY ?= $(shell openssl rand -hex 32)

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --service searxng-app
	cd app && railway up --service searxng-app
	railway variable set --service searxng-app SEARXNG_SECRET_KEY=$(SECRET_KEY)

destroy:
	@echo "Delete services via Railway dashboard: searxng-app"
	@echo "https://railway.app/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service searxng-app --lines 100

.PHONY: deploy destroy status logs
