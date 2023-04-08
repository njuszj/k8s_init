# /bin/bash
# ubuntu 20.04

./install_kube.sh

# create worker node
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

hostnamectl set-hostname "worker$1"
