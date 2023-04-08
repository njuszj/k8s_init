# /bin/bash
# ubuntu 20.04

# install kubeadm
mkdir /etc/apt/keyrings
curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -y kubelet kubeadm kubectl

# install docker
apt install docker.io

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
