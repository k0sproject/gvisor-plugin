# k0s gVisor Plugin

This repo provides a plugin "installer" for k0s to setup [gVisor runtime](https://gvisor.dev/).

It leverages the new k0s containerd plugin "framework" to dynamically configure k0s managed containerd.

## Running the installer

Check the example manifest in [manifests/](manifests/) directory.

Essentially it runs as a `DaemonSet` and does the following:

- Drops gVisor binaries into k0s bin dir at `/var/lib/k0s/bin`
- Drops gVisor CRI plugin configuration into `/etc/k0s/containerd.d/`

Once k0s sees the drop-in configuration it will automatically reload the containerd configuration.

If you do not wish to install gVisor on all worker nodes you can customize the manifest with your own `nodeSelector`.

## Supported archs

Currently gVisor supports `amd64` and `arm64` architectures and thus this installer also supports those.

