APP = restapi

lint:
	@flake8

compose:
	@docker compose build
	@docker compose up -d