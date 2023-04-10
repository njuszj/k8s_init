start_master.sh > kubeadm.out 2>&1
KUBE_JOIN=`tail -n 2 kubeadm.out | xargs echo | xargs echo`
echo "$KUBE_JOIN"
read -p "continue?(y/n)" cont
if [[ $cont == "y" ]]; then
        ssh worker1 "/root/script/clean.sh && $KUBE_JOIN"
        ssh worker2 "/root/script/clean.sh && $KUBE_JOIN"
fi