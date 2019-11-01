#!/usr/bin/env bash

# Antes de continuar, certifique-se de que seu sistema operacional é Ubuntu 18.04 e suas credenciais aws estão configuradas localmente dentro de ~/.aws/credentials"
# Certifique-se também de que a região configurada na AWS é a us-east-1"
# Para visualizar sua atual configuração digite o comando: aws configure list"
# OBS.: Se os requisitos acima não forem atendidos esse script não executará corretamente."

REGION=`aws configure list | awk -v OFS="," '$1=$1' | tail -1 | cut -d',' -f2`

if [ $REGION != "us-east-1" ]; then
    echo "Sua região não é us-east-1. Por favor configure corretamente sua região utilizando o comando 'aws configure'."
    exit
fi

ls k8s-key*
if [ $? -ne 0 ]; then
    ssh-keygen -f ./k8s-key
    mv k8s-key ../ansible
fi

cat > variables.tf << EOF
variable "public_key" {
    default = "`cat k8s-key.pub`"
}

variable "sg_ingress_ports" {
  default = ["22", "6443", "2379", "2380", "10250", "10251", "10252"]
}
EOF

ls terraform
if [ $? -ne 0 ]; then
    wget -O terraform.zip https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip
    unzip terraform.zip -d .
    rm -rf terraform.zip
fi

./terraform init
./terraform apply -auto-approve

cat > ../ansible/hosts << EOF
[master:vars]
ansible_ssh_private_key_file=k8s-key
ansible_user=ubuntu

[master]
`./terraform output | cut -d' ' -f3`
EOF

rm -rf terraform