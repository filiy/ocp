# OpenShift Logging 

OpenShift Logging is made up of several components depending on how you need it deployed.

The Loki, OpenShift-Logging, and Cluster Observability operators all get installed. The Cluster Log Forwarding yaml defines where to forward logs. The Lokistack yaml defines how the Loki log storage system is deployed.

* https://docs.redhat.com/en/documentation/red_hat_openshift_logging/6.3/

The `logging-loki-odf` secret will need to be created for Loki to write to the internal s3 bucket. This will require some manual steps as we have an ObjectBucketClaim that will create a bucket for us but it will also create creds to access the bucket. Steps are below to create the secret.

* https://docs.redhat.com/en/documentation/red_hat_openshift_logging/6.3/html/configuring_logging/configuring-lokistack-storage#logging-loki-storage-odf_configuring-the-log-store

