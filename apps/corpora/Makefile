install: build release deploy test

build:
	docker build --tag localhost:5000/labs/corpora .

run:
	docker run -d --name corpora -p 8080:80 localhost:5000/labs/corpora

release:
	docker push localhost:5000/labs/corpora

deploy:
	kubectl -n corpora apply -f ./k8s

delete:
	kubectl -n corpora delete -f ./k8s

test:
	@echo "Running tests -- may take a few seconds"
	@./test.sh > /dev/null
	@echo "Passed"
