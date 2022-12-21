PLATFORMS=linux/amd64,linux/arm64,linux/arm,linux/ppc64le
PREFIX=quay.io/dcain
IMAGE_VER=1.0

images: Containerfile
	podman build --rm --platform $(PLATFORMS) -t $(PREFIX)/rt-tests-podman:$(IMAGE_VER) .