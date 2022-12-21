FROM --platform=${BUILDPLATFORM} registry.access.redhat.com/ubi8 as builder

RUN dnf -y update && dnf -y --setopt=tsflags=nodocs install \
    gcc git make numactl-devel numactl-libs python39 \
  && rm -rf /var/cache/dnf

RUN git clone -b main git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git && \
    cd rt-tests && \
    make all && \
    make install && \
    cd .. && \
    rm -rf rt-tests 

########
FROM --platform=${BUILDPLATFORM} registry.access.redhat.com/ubi8

RUN dnf -y update && dnf -y --setopt=tsflags=nodocs install \
    numactl-libs python39 \
  && rm -rf /var/cache/dnf

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/src /usr/local/src
COPY --from=builder /usr/lib/python3.9/site-packages/ /usr/lib/python3.9/site-packages/

LABEL   io.k8s.display-name="Realtime Tools" \
        io.k8s.description="Container with realtime tools for tests" \
        io.openshift.tags="rt-tests"

ENTRYPOINT /bin/bash -c "sleep infinity"
