APP = restapi-flask

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

start-dev:
	@minikube start
	@helm upgrade \
		--install \
		--set image.tag=5.0.8 \
		--set auth.rootPassword="root" \
		mongodb kubernetes/charts/mongodb
	@kubectl wait \
		--for=condition=ready pod \
		--selector=app.kubernetes.io/component=mongodb \
		--timeout=270s

deploy-dev:
	@docker build -t $(APP):latest .
	@minikube image load $(APP):latest
	@kubectl apply -f k8s/manifests
	@kubectl rollout restart deploy $(APP)

dev: start-dev deploy-dev

clean:
	@docker compose down
	@minikube delete