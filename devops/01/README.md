# DevOps Hiring Test - Apresentação da POC

**Stack**
- IAC: Terraform e Ansible
- Infraestrutura: Kubernetes implementado com kubadm na AWS
- App: node / deploy com helm
- CI: gitlab-ci configurado no diretório do app

**Cenário e dificuldades**
Devido a não ter acesso a uma infraestrutura de laboratório AWS, precisei usar o free-tier (t2.micro) com 1GB RAM e 1 vCPU. O impacto de ter usado o free-tier me tomou muito tempo e consequentemente acabei não conseguindo concluir o desafio por completo. Abaixo eu listo alguns impactos de ter usado free-tier:
- O master node do kubernetes exige pelo menos 2 GB de RAM. Com uma opção específica do kubeadm eu consegui passar por essa verificação e instalar o master node em uma t2.micro, porém os serviços básicos para subir o cluster já consomem boa parte da capacidade computacional da instância
- O tempo gasto com a parte de IAC (dev e testes) acabou impossibilitando a entrega de parte do desafio em tempo ágil e eficiente

**Serviços não entregues**
- Monitoria: o plano era impĺementar um prometheus através de um chart helm, porém como estava limitado em recurso computacional, não foi possível
- Integração Contínua: a intenção era fazer uma integração contínua apenas do app utilizando a infraestrutura criada. Inclusive no terraform eu crio o ECR que será usado como registry das imagens do app, porém não consegui colocar em prática o CI

**Sobre o "plus"**
- Criei um kubernetes com kubeadm via ansible
- Criei um healthcheck utilizando um módulo já desenvolvido, porém como não consegui implementar monitoração acabei não seguindo com melhores configurações
- Como não consegui seguir com o CI, tentei automatizar a criação da infra e cluster através de apenas 2 scripts em shell

# Instruções de execução do projeto
O projeto se resume a 2 execuções em script e 2 etapas manuais:
- Script "install_infra.sh" que se encontra no diretório infra/terraform
- Script "install_k8s.sh" que se encnontra no diretório infra/ansible
- Garantir que você realizou as instruções finais do script "install_k8s.sh" para conexão com o cluster
- Realizar o build do Dockerfile e deploy da imagem gerada no cluster via HELM

**Observações Importantes**
- Devido a limitações de recursos, o deploy via helm não foi testado
- Não foi implementado um ingress controller no kubernetes, sendo assim desconsidere a implementação de ingress
- O serviço está configurado para ser implementado como NodePort na porta 3000, sendo assim quando a aplicação ficar online basta apenas acessar o IP público do node na porta 3000
- Se possível, altere o tipo de instância no recurso "aws_instance" arquivo "terraform/main.tf" para uma instância com maior capacidade computacional. Isso ajudará tanto na subida dos recursos, como também em colocar o app online
- Caso não consiga alterar o tipo de instância, pode acontecer do script ansible apresentar alguns erros devido a infraestrutura do kubernetes demorar um pouco para subir, porém executando-o novamente funciona corretamente.
- Depois de subir o terraform, aguarde alguns segundos antes de subir o cluster. Muitas vezes a conexão com a instância ainda não está 100% disponível
- Não há resource limit configurado para o pod, pois se trata apenas de um "hello world"




Dentro deste repositório temos uma aplicação que deve o cargo e o nome do candidato, portanto é necessário corrigir conforme necessário.

**Os Pré-Requisitos para esse teste são:**

- A infraestrutura deverá subir com alguma ferramenta de IAC (Terraform, Cloudformation, Ansible); :heavy_check_mark:
- Subir a app com [HELM](https://helm.sh/) num cluster de Kubernetes; :heavy_check_mark:
- Ter monitoria e logs para a aplicação (gostamos de soluções OpenSource). :heavy_check_mark:
- Apresentar um flow lógico para integração contínua e automatização de processos; :heavy_check_mark:

**Plus**

- Além do helm, mostrar conceitos básicos de Kubernetes; 
- Criar um Health Check para a aplicação, garantindo que está tudo no ar;
- Utilize sua criatividade para entregar os itens solicitados. Pode-se utilizar scripts e outras ferramentas que tenha familiaridade.


Para entregar o teste, crie um repositório com a sua solução e nos mande para o email jacqueline.mello@avecbrasil.com.br.
