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

dev:
	@minikube start
	# @kubectl apply -f k8s/config/config.yml
	@helm upgrade \
		--install \
		--set image.tag=5.0.8 \
		--set auth.rootPassword="root" \
		mongodb kubernetes/charts/mongodb
	@kubectl wait \
		--for=condition=ready pod \
		--selector=app.kubernetes.io/component=mongodb \
		--timeout=270s

clean:
	@docker compose down
	@minikube stop