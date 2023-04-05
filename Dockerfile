FROM alpine as build
# ARG VERSION=20230313 does not work, dunno why...
ARG VERSION=latest
ARG TARGETARCH

ENV URL=https://storage.googleapis.com/gvisor/releases/release/${VERSION}

RUN case $(uname -m) in amd64|x86_64) ARCH="x86_64" ;; arm64|aarch64) ARCH="aarch64" ;; esac  && \
    wget ${URL}/${ARCH}/runsc ${URL}/${ARCH}/runsc.sha512 ${URL}/${ARCH}/containerd-shim-runsc-v1 ${URL}/${ARCH}/containerd-shim-runsc-v1.sha512

RUN sha512sum -c runsc.sha512 -c containerd-shim-runsc-v1.sha512 && \
    rm -f *.sha512 && \
    chmod a+rx runsc containerd-shim-runsc-v1



FROM alpine
RUN mkdir /artifacts
COPY --from=build /runsc /artifacts/runsc
COPY --from=build /containerd-shim-runsc-v1 /artifacts/containerd-shim-runsc-v1

COPY gvisor.toml /artifacts/gvisor.toml
COPY --chmod=755 install.sh /bin/install.sh


CMD ["/bin/install.sh"]