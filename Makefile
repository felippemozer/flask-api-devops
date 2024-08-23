APP = restapi

lint:
	@black . --check
	@flake8

codesec:
	@bandit -c bandit.yml -r .

test: lint codesec
	@pytest -v --disable-warnings

compose:
	@docker compose build
	@docker compose up -d

clean:
	@docker compose down