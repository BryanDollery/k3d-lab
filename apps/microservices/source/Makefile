.PHONY: k8s

run: stop start logs

dev:
	npm install
	docker build --tag localhost:5000/labs/ndsobc-$$(basename $$PWD) -f Dockerfile-dev .

build:
	docker build --tag localhost:5000/labs/ndsobc-$$(basename $$PWD) .

push:
	docker push localhost:5000/labs/ndsobc-$$(basename $$PWD)

PORT := 80
EXPOSED_PORT := 9100

start:
	docker container run -it -d \
		   -v "$$PWD":/"$$(basename $$PWD)" \
		   -w "/$$(basename $$PWD)" \
			 -p 3000:3000 \
		   --hostname "$$(basename $$PWD)" \
		   --name "$$(basename $$PWD)" \
		   localhost:5000/labs/ndsobc-$$(basename $$PWD)

exec:
	docker exec -it "$$(basename $$PWD)" bash || true

stop:
	docker rm -f "$$(basename $$PWD)" 2> /dev/null || true

logs:
	docker logs -f "$$(basename $$PWD)" | pino-pretty -t "SYS:HH:MM:ss" -c -l -i pid,hostname

k8s:
	kubectl apply -f ./k8s
