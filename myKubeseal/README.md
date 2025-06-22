# Installation Instructions

## Client Side

* Install the client-side tool into `/usr/local/bin/`:
  * Releases: https://github.com/bitnami-labs/sealed-secrets/releases/
    ```bash
    # On Linux
    curl -OL "https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.30.0/kubeseal-0.30.0-linux-amd64.tar.gz"
    tar -xvzf kubeseal-0.30.0-linux-amd64.tar.gz kubeseal
    sudo install -m 755 kubeseal /usr/local/bin/kubeseal
    
    # mac
    brew install kubeseal
    
    # windows
    ???
    ```

## Cluster Side

* Install the `SealedSecret` CRD and server-side controller into the `kube-system` namespace.
  * Release `v0.30.0`: https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.30.0/controller.yaml
    ```bash
    kubectl apply -f controller.yaml
    
    # Or
    kubectl apply -f https://github.com/bitnami-labs/sealed-secrets/releases/download/<release>/controller.yaml
    
    # check logs
    kubectl logs -n kube-system sealed-secrets-controller-<pod_suffix>
    ```

## Publish Secret

* Get public RSA key:
    ```bash
    kubeseal --fetch-cert > cert.pem
  
    # Attention : vérifier la durée du cert
    openssl x509 -enddate -noout -in cert.pem
    ```
* Encode your secrets (base64)
    ```bash
    echo "secret" | base64
    c2VjcmV0Cg==
    ```
* Add secret to manifest:
    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: mysecrets
      namespace: mynamespace
    type: Opaque
    data:
      secret: c2VjcmV0Cg==
    ```

* Encrypt your secrets (`cert.pem`)
    ```bash
    kubeseal --cert cert.pem -o yaml --scope strict < mySecrets.yaml > sealedsecret.yaml
    ```

* Check the generated `sealedsecret.yaml` file:
    ```bash
    cat sealedsecret.yaml
    ```

* Create `sealedsecret` from manifest:
    ```bash
    kubectl apply -f sealedsecret.yaml
    ```

* Check the deployed `secret` and `sealedsecret` resource:
    ```bash
    kubectl get secret -n mynamespace
  
    kubectl get sealedsecret -n mynamespace
    ```