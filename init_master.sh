# /bin/bash
# ubuntu 20.04

./install_kube.sh

# config master node
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

hostnamectl set-hostname master

echo "Input host, use EOF to end"

while read line; do
    if [[ $line == "EOF" ]]; then
        break
    fi
    echo "$line" >> /etc/hosts
done

echo "Input master ip: "
read ip
echo "EXPORT masterIP=$ip" >> /root/.bashrc
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /root/.bashrc
source /root/.bashrc
