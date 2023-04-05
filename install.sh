#!/bin/sh

IMPORTS_DIR="/etc/k0s/containerd.d/"
BIN_DIR="/var/lib/k0s/bin/"

echo "Installing gVisor binaries to ${BIN_DIR}"
cp /artifacts/runsc ${BIN_DIR}
cp /artifacts/containerd-shim-runsc-v1 ${BIN_DIR}

echo "Installing containerd config to ${IMPORTS_DIR}"
cp /artifacts/gvisor.toml ${IMPORTS_DIR}/gvisor_runtime.toml 
