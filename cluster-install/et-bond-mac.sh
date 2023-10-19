#!/usr/bin/bash
cat <<EOF > /etc/NetworkManager/conf.d/99-bond-mac.conf
[connection-bond0]
match-device=interface-name:bond0
ethernet.cloned-mac-address=$(ip -j link show dev ens192 | jq -r .[0].address)
EOF
