LATEST_PHP8_VERSION=8.2
LATEST_PHP7_VERSION=7.4

IMAGE_REGISTRY="phpimageleague"
IMAGE_NAME="php-application-server"
IMAGE_FULL="$(IMAGE_REGISTRY)/$(IMAGE_NAME)"

define docker-tag
    echo "Tagging $(IMAGE_FULL):$(2)"
    docker image tag "$(1)" "$(IMAGE_FULL):$(2)"
	docker image push "$(IMAGE_FULL):$(2)"
endef

build: compile build-base

compile: compile-base

build-base: compile-base
	docker build --tag build-base --build-arg "PHP_VERSION=$$PHP_VERSION" base

compile-base:
	cd ./base && ../preprocessor "$$TAG.Dockerfile" > Dockerfile

tag:
	@docker pull $(IMAGE)
	@$(call docker-tag,$(IMAGE),"$(TAG)-$(PHP_VERSION)")
ifeq ($(PHP_VERSION),$(LATEST_PHP8_VERSION))
	@$(call docker-tag,$(IMAGE),"$(TAG)")
	@$(call docker-tag,$(IMAGE),"$(TAG)-8")
ifeq ($(TAG),fpm)
	@$(call docker-tag,$(IMAGE),"latest")
endif
endif
ifeq ($(PHP_VERSION),$(LATEST_PHP7_VERSION))
	@$(call docker-tag,$(IMAGE),"$(TAG)-7")
endif
