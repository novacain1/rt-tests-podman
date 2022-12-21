PLATFORMS=linux/arm64
#PLATFORMS=linux/amd64,linux/arm64,linux/arm,linux/ppc64le
PREFIX=quay.io/dcain
IMAGE_VER=0.7

images: Containerfile
	podman build --rm --platform $(PLATFORMS) -t $(PREFIX)/rt-tests-podman:$(IMAGE_VER) .
	#podman build --rm --all-platforms -t $(PREFIX)/rt-tests-podman:$(IMAGE_VER) .
