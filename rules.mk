# Boilerplate
p := $(p).x
dirstack_$(p) := $(d)
d := $(dir)

# Local rules and targets
ifndef ZOOKEEPER_VERSION
$(error ZOOKEEPER_VERSION is undefined)
endif

DOCKER_IMAGE_$(d) := b9company/zookeeper
DOCKER_TAG_$(d) := $(ZOOKEEPER_VERSION)

BUILD := $(BUILD) build_$(d)
PUSH := $(PUSH) push_$(d)

build_$(d): DOCKER_IMAGE := $(DOCKER_IMAGE_$(d))
build_$(d): DOCKER_TAG := $(DOCKER_TAG_$(d))
build_$(d): DOCKER_CONTEXT := $(d)
build_$(d): ZOOKEEPER_MIRROR := http://apache.crihan.fr/dist/zookeeper
build_$(d): ZOOKEEPER_DATADIR := /var/lib/zookeeper
build_$(d): ZOOKEEPER_DATALOGDIR := /var/log/zookeeper
build_$(d): $(d)/Dockerfile
	docker build \
		--build-arg ZOOKEEPER_VERSION="$(ZOOKEEPER_VERSION)" \
		--build-arg ZOOKEEPER_MIRROR="$(ZOOKEEPER_MIRROR)" \
		--build-arg ZOOKEEPER_DATADIR="$(ZOOKEEPER_DATADIR)" \
		--build-arg ZOOKEEPER_DATALOGDIR="$(ZOOKEEPER_DATALOGDIR)" \
		$(if $(ZOOKEEPER_ARCHIVE),--build-arg ZOOKEEPER_ARCHIVE="$(ZOOKEEPER_ARCHIVE)") \
		-t "$(DOCKER_IMAGE):$(DOCKER_TAG)" "$(DOCKER_CONTEXT)"

push_$(d): DOCKER_IMAGE := $(DOCKER_IMAGE_$(d))
push_$(d): DOCKER_TAG := $(DOCKER_TAG_$(d))
push_$(d):
	docker push "$(DOCKER_IMAGE):$(DOCKER_TAG)"

# Boilerplate
d := $(dirstack_$(p))
p := $(basename $(p))
