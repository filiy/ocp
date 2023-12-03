## ACM OCP "Baremetal" BYO LB/DNS VM Install

Assuming ACM is installed and ready to go.

* Install Bind, use `named.conf` file & `lab-bind-zone` file. Start/enable service
* Install haproxy. Use `haproxy.cfg` file. Run `setsebool -P haproxy_connect_any=1`. Start/enable service.
* Add entries for firewall or stop firewalld service.
* Install nmstate operator in cluster add `nncp-extra-dns.yaml` to cluster. Update with IP of bastion acting as DNS server.
* Create blank VMs in vCenter.
* Update `lab-nmstate.yaml` with rights IPs and mac addresses from VMs. Apply to cluster
* Create infrastructre environment in ACM. Make sure disk is big enough for images
* Download ISO from ACM. Update to datastore and mount to VMs in vsphere.
* Create cluster from 3 nodes.
* If cluster install is hanging and seems like ETCD pod won't start on VM that was bootstrap this command seems to work to get things going. `oc patch etcd/cluster --type=merge -p '{"spec": {"unsupportedConfigOverrides": {"useUnsupportedUnsafeNonHANonProductionUnstableEtcd": true}}}'`
