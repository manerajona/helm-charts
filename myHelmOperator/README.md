$ kubectl create ns flux
$ ssh-keygen -q -N "" -f ./identity
$ kubectl -n flux create secret generic helm-ssh --from-file=./identity
$ ssh-keyscan github.com

set fingerpring in values (git.ssh.known_hosts)

$ helm install -n flux helm-operator fluxcd/helm-operator -f helm-operator-values.yaml

create helm.fluxcd.io/v1/HelmRelease resource for CD. See: helm-release-example.yaml

$ kubectl apply -f helm-release-example.yaml