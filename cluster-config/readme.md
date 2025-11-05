Progressive Syncs.

* https://argo-cd.readthedocs.io/en/latest/operator-manual/applicationset/Progressive-Syncs/
* https://argo-cd.readthedocs.io/en/stable/proposals/2022-07-13-appset-progressive-rollout-strategy/#alternatives

Enable in OpenShift:

`oc patch argocd openshift-gitops -n openshift-gitops --type merge -p '{"spec":{"applicationSet":{"env":[{"name":"ARGOCD_APPLICATIONSET_CONTROLLER_ENABLE_PROGRESSIVE_SYNCS","value":"true"}]}}}'`



Create admin policy if not created and map to the ArgoCD admin user.

```yaml
  rbac:
    defaultPolicy: ''
    policy: |
      p, role:admin, *, *, *, allow
      g, admin, role:admin
```

Login and sync the cluster-config ApplicationSet:

```bash
argocd login openshift-gitops-server.openshift-gitops.svc.cluster.local
argocd app sync --selector appset=cluster-config
```