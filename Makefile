APP      := app
REGISTRY := ghcr.io/chumachenko-vy
VERSION  := $(shell git rev-parse --short HEAD 2>/dev/null || echo dev)

HOST_OS   := $(shell uname -s | tr '[:upper:]' '[:lower:]')
HOST_ARCH := $(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/aarch64/arm64/')

TARGETOS   ?= $(HOST_OS)
TARGETARCH ?= $(HOST_ARCH)

IMAGE_TAG := $(REGISTRY)/$(APP):$(VERSION)-$(TARGETOS)-$(TARGETARCH)

.PHONY: build test image push linux arm macos windows clean

build:
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o $(APP) .

test:
	go test -v ./...

image:
	docker build . -t $(IMAGE_TAG) \
		--build-arg TARGETOS=$(TARGETOS) \
		--build-arg TARGETARCH=$(TARGETARCH)

push:
	docker push $(IMAGE_TAG)

linux:
	$(MAKE) image TARGETOS=linux TARGETARCH=amd64

arm:
	$(MAKE) image TARGETOS=linux TARGETARCH=arm64

macos:
	$(MAKE) image TARGETOS=darwin TARGETARCH=arm64

windows:
	$(MAKE) image TARGETOS=windows TARGETARCH=amd64

clean:
	rm -f $(APP)
	-docker rmi $(IMAGE_TAG)
