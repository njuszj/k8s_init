swapoff -a
kubeadm reset -f
kubeadm init --apiserver-advertise-address=$masterIP --service-cidr=10.1.0.0/16 --pod-network-cidr=10.244.0.0/16
