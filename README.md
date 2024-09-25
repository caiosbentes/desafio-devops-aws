# CI/CD Pipeline com Amazon EKS e GitHub Actions

Este documento descreve como configurei um pipeline de CI/CD usando Docker, Amazon ECR, Amazon EKS e GitHub Actions.

## Etapas do Pipeline

### 1. Containerizei a Aplicação

1. Criei um `Dockerfile` para empacotar a aplicação Python.
2. No `Dockerfile`, usei uma imagem base Python, copiei os arquivos necessários e instalei as dependências.

### 2. Configurei o Amazon ECR (Elastic Container Registry)

1. Criei um repositório privado no Amazon ECR para armazenar as imagens Docker da aplicação.

### 3. Configurei o Amazon EKS (Elastic Kubernetes Service)

1. Configurei um cluster EKS na AWS para hospedar a aplicação.

### 4. Criei o Pipeline de CI/CD com GitHub Actions

1. Criei o arquivo `.github/workflows/ci-cd.yml` para definir o pipeline.
2. Configurei o pipeline para ser acionado em pushs para a branch `main` ou em pull requests.
3. Implementei as seguintes etapas no pipeline:
   - **Build e push da imagem Docker para o ECR.**
   - **Deploy da nova versão no cluster EKS.**

### 5. Defini os Manifestos Kubernetes

1. Criei os arquivos `kubernetes/deployment.yaml` e `kubernetes/service.yaml` para definir como a aplicação será implantada no cluster.

### 6. Configurei Secrets

1. Configurei as seguintes secrets no repositório GitHub:
   - `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`: Para autenticação na AWS.
   - `KUBE_CONFIG_DATA`: Configuração do `kubectl` para acessar o cluster EKS.

## Implementação do Pipeline

1. Criei um repositório no GitHub e fiz push do código da aplicação, `Dockerfile` e arquivos de configuração.
2. Configurei o Amazon ECR e EKS na minha conta AWS.
3. Configurei as secrets necessárias no repositório GitHub.
4. Fiz um commit e push para a branch `main` para acionar o pipeline.

O pipeline automatiza o processo de build, push para o registry privado (ECR) e deploy no cluster EKS.

## Simulação de um Deploy Completo

1. Fiz alterações no código e criei um pull request.
2. O pipeline foi acionado, buildando e testando a nova versão.
3. Após aprovação e merge do PR, o pipeline construiu a imagem final, fez push para o ECR e atualizou o deployment no EKS.

## Implementação de GitOps com ArgoCD

1. Instalei o ArgoCD no meu cluster EKS.
2. Criei um repositório Git separado para os manifestos Kubernetes.
3. Configurei o ArgoCD para observar este repositório.
4. Modifiquei o pipeline para atualizar o repositório de manifestos após o build da imagem.
5. O ArgoCD detecta as mudanças e aplica automaticamente as atualizações no cluster.

## Conclusão

Essa solução fornece um pipeline de CI/CD automatizado usando um registry privado (ECR) e explica como implementei GitOps com ArgoCD. Adaptei e expandi essa configuração conforme necessário para atender aos requisitos específicos do meu projeto.

