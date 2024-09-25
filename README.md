# CI/CD Pipeline com Amazon EKS e GitHub Actions

Este documento descreve a configuração de um pipeline de CI/CD utilizando Docker, Amazon ECR, Amazon EKS e GitHub Actions.

## Etapas do Pipeline

### 1. Containerização da Aplicação

1. Criei um `Dockerfile` para empacotar a aplicação Python.
2. No `Dockerfile`, utilizei uma imagem base Python, copiei os arquivos necessários e instalei as dependências.

Para construir e executar o contêiner Docker, use os seguintes comandos:

```sh
docker build -t flask-comment-app .
```

```sh
docker run -d -p 5000:5000 flask-comment-app
```

Teste a API utilizando `curl` ou uma ferramenta como o Postman:

```sh
curl -X POST http://localhost:5000/api/comment/new -H "Content-Type: application/json" -d '{"email": "user@example.com", "comment": "Great post!", "content_id": 1}'
```

```sh
curl http://localhost:5000/api/comment/list/1
```

### 2. Configuração do Amazon ECR

1. Criei um repositório privado no Amazon ECR para armazenar as imagens Docker da aplicação.

### 3. Configuração do Amazon EKS (Elastic Kubernetes Service)

1. Configurei um cluster EKS na AWS para hospedar a aplicação de forma escalável e segura.

### 4. Criação do Pipeline de CI/CD com GitHub Actions

1. Criei o arquivo `.github/workflows/ci-cd.yml` para definir o pipeline de CI/CD.
2. Configurei o pipeline para ser acionado em pushs para a branch `main` ou em pull requests.
3. Implementei as seguintes etapas no pipeline:
   - **Build e push da imagem Docker para o ECR.**
   - **Deploy da nova versão no cluster EKS.**

### 5. Definição dos Manifestos Kubernetes

1. Criei os arquivos de manifesto Kubernetes na pasta `k8s`, definindo como a aplicação será implantada no cluster EKS.

### 6. Configuração de Secrets

1. Configurei as seguintes secrets no repositório GitHub:
   - `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`: Para autenticação na AWS.
   - `KUBE_CONFIG_DATA`: Configuração do `kubectl` para acesso ao cluster EKS.

## Implementação do Pipeline

1. Criei um repositório no GitHub e fiz o push do código da aplicação, `Dockerfile` e arquivos de configuração.
2. Configurei o ECR e o EKS na minha conta AWS.
3. Adicionei as secrets necessárias no repositório GitHub.
4. Fiz um commit e push para a branch `main` para acionar o pipeline.

O pipeline automatiza o processo de build, push para o registry privado (ECR) e deploy no cluster EKS, garantindo que novas versões sejam disponibilizadas rapidamente e de forma consistente.

## Simulação de um Deploy Completo

1. Fiz alterações no código e criei um pull request.
2. O pipeline foi acionado, realizando o build e testes da nova versão.
3. Após a aprovação e o merge do PR, o pipeline construiu a imagem final, fez o push para o ECR e atualizou o deployment no EKS.

## Implementação de GitOps com ArgoCD

1. Instalei o ArgoCD no cluster EKS para gerenciar o estado desejado do cluster.
2. Criei um repositório Git separado para armazenar os manifestos Kubernetes.
3. Configurei o ArgoCD para monitorar este repositório e aplicar mudanças automaticamente.
4. Ajustei o pipeline para atualizar o repositório de manifestos após o build da imagem.
5. O ArgoCD detecta as mudanças e aplica automaticamente as atualizações no cluster.

## Conclusão

Esta solução implementa um pipeline de CI/CD automatizado utilizando Amazon ECR e EKS, integrando práticas de GitOps com ArgoCD. A configuração pode ser adaptada conforme necessário para atender aos requisitos específicos de cada projeto, fornecendo um fluxo de entrega contínua eficiente e escalável.
