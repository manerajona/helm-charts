### init
The helmfile init sub-command checks the dependencies required for helmfile operation, such as helm, helm diff plugin, helm secrets plugin, helm helm-git plugin, helm s3 plugin. When it does not exist or the version is too low, it can be installed automatically.

```bash
helmfile init
```

### Apply
An expected use-case of apply is to schedule it to run periodically, so that you can auto-fix skews between the desired and the current state of your apps running on Kubernetes clusters.

```bash
helmfile apply
```