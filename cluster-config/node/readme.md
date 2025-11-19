# OpenShift Machine Configs

Files here will update files on the OpenShift nodes. 

**Warning!!**

Most MachineConfig files will cause a rolling restart of all nodes in the cluster.

## BareMetalHosts

You'll need to update the BMH objects that the installer creates with the below. The secret is on the AG-OCVW-TDM101 host.

```
  bmc:
    address: 'ipmi://10.123.32.154'
    credentialsName: ilo-creds
```