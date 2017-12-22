VERSION := $(shell cat VERSION)
IMAGE   := gcr.io/hc-public/peatio-charts:$(VERSION)

.PHONY: default build push run ci deploy

default: build run

build: repo build-server
	@echo -e '\033[1m> Building "peatio-charts" docker image\033[0m'
	@docker build -t $(IMAGE) .

push: build
	@echo -e '\033[1m> Pushing the container\033[0m'
	docker push $(IMAGE)

run:
	@echo -e '\033[1m> Starting "peatio-charts" container\033[0m'
	@docker run -p 8080:8080 -d $(IMAGE)

ci:
	@echo -e '\033[1m> Updating CI pipeline\033[0m'
	@fly -t ci set-pipeline -p peatio-charts -c config/pipelines/review.yml -n
	@fly -t ci unpause-pipeline -p peatio-charts

deploy:
	@echo -e '\033[1m> Deploying\033[0m'
	@helm install ./config/charts/peatio-charts --set "image.tag=$(VERSION)"

repo:
	@echo -e '\033[1m> Indexing helm repo\033[0m'
	@bin/index

build-server:
	@echo -e '\033[1m> Building server\033[0m'
	@CGO_ENABLED=0 go build -tags netgo -a server.go
