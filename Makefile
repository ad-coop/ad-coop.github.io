HUGO_VERSION := $(shell cat .hugo-version)
export HUGO_VERSION

.PHONY: build serve shell clean env

env:
	@echo "HUGO_VERSION=$(HUGO_VERSION)" > .env

build: env
	docker compose build

serve: build
	docker compose up hugo

shell: build
	docker compose run --rm shell

clean:
	docker compose down --rmi local
