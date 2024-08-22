APP = restapi

lint:
	@flake8

test: lint
	@pytest -v --disable-warnings

compose:
	@docker compose build
	@docker compose up -d

clean:
	@docker compose down