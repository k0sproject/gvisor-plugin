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

## Running a pod using gVisor

You can simply create a pod using the newly installed gVisor runtime:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-gvisor
spec:
  runtimeClassName: gvisor
  containers:
  - name: nginx
    image: docker.io/nginx:1-alpine
```

The key here is `runtimeClassName: gvisor` which instructs containerD to use gVisor (`runsc`) runtime when it creates the container.

Once the pod is running exec into the pod and check that gVisor is being used:

```sh
$ kubectl exec -it  nginx-gvisor -- dmesg
[   0.000000] Starting gVisor...
```

Vóila, now your Nginx is executed using gVisor.


## Supported archs

Currently gVisor supports `amd64` and `arm64` architectures and thus this installer also supports those.

