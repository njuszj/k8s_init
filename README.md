# k8s_init
bash script to init kubernetes based on kubeadm

+ docker is the container runtime
+ version: 
    + kube: 1.22.0
    + docker.io: 20.10.21

# how to use
## 1. for master node
init_master -> start_master -> config_network

## 2. for worker node
init_worker -> start_worker

