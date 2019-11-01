#!/usr/bin/env bash

# Antes de continuar, certifique-se de que seu sistema operacional é Ubuntu 18.04.
# OBS.: Se os requisitos acima não forem atendidos esse script não executará corretamente.

if [ -z `command -v ansible` ]; then
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -y ansible
fi

ansible-playbook setup_master_node.yml

LOCAL_IP=`grep "kubeadm join" playbooks/join_token | cut -d' ' -f3`
PUBLIC_IP=`tail -1 hosts`

sed -i "s/$LOCAL_IP/$PUBLIC_IP:6443/g" playbooks/kubeconfig

echo "A chave gerada para seu acesso ao server é `pwd/k8s-key`"
echo "Use o arquivo gerado em `pwd`/playbooks/kubeconfig para acessar o cluster como admin."
echo "O comando para utilizar esse arquivo como configuração default é: export KUBECONFIG=`pwd`/playbooks/kubeconfig"
echo "Para desfazer essa configuração use o comando: unset KUBECONFIG"
