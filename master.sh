# /bin/bash
# ubuntu 20.04

read | sudo passwd
read | su


# install kubeadm
mkdir /etc/apt/keyrings
curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg 

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -y kubelet kubeadm kubectl


# create master node
swapoff -a

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
    echo "$line" >> /etc/host
done

apt install docker.io
kubeadm reset -f

echo "Input master ip: "
read ip
kubeadm init --apiserver-advertise-address=$ip --service-cidr=10.1.0.0/16 --pod-network-cidr=10.244.0.0/16
