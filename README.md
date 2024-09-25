# CI/CD Pipeline com Amazon EKS e GitHub Actions

Este documento descreve a configuração de um pipeline de CI/CD utilizando Docker, Amazon ECR, Amazon EKS e GitHub Actions.

## Etapas do Pipeline

### 1. Containerização da Aplicação

1. Criei um `Dockerfile` para empacotar a aplicação Python.
2. No `Dockerfile`, utilizei uma imagem base Python, copiei os arquivos necessários e instalei as dependências.

Para construir e executar o contêiner Docker localmente, use os seguintes comandos:

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

### 5. Configuração do repositório:

Criei um repositório no GitHub com duas pastas principais:

1. `src`: para o código-fonte da aplicação
2. `k8s`: para os manifestos Kubernetes (YAML)

### 6. Configuração de Secrets

1. Configurei as seguintes secrets no repositório GitHub:
   - `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`: Para autenticação na AWS.
   - `KUBE_CONFIG_DATA`: Configuração do `kubectl` para acesso ao cluster EKS.

### 7. Implementação do Pipeline

1. Criei um repositório no GitHub e fiz o push do código da aplicação, `Dockerfile` e arquivos de configuração.
2. Configurei o ECR e o EKS na minha conta AWS.
3. Adicionei as secrets necessárias no repositório GitHub.
4. Fiz um commit e push para a branch `main` para acionar o pipeline.

O pipeline automatiza o processo de build, push para o registry privado (ECR) e deploy no cluster EKS, garantindo que novas versões sejam disponibilizadas rapidamente e de forma consistente.

### 8. Simulação de um Deploy Completo

1. Fiz alterações no código e criei um pull request.
2. O pipeline foi acionado, realizando o build e testes da nova versão.
3. Após a aprovação e o merge do PR, o pipeline construiu a imagem final, fez o push para o ECR e atualizou o deployment no EKS.

Para implementar um deploy automatizado usando GitOps de ponta a ponta com GitHub Actions, ArgoCD, EKS e ECR, podemos seguir os seguintes passos:


### 9. Configuração do GitHub Actions:
Crie um workflow no GitHub Actions (.github/workflows/ci-cd.yml) que será acionado em cada commit na branch principal:
GitHub Actions Workflow for CI/CDClick to open code

### 10. Configuração do ArgoCD:

Instale o ArgoCD no seu cluster EKS.
Configure o ArgoCD para monitorar o repositório GitHub:
```sh
argocd app create my-app \
  --repo https://github.com/seu-usuario/seu-repo.git \
  --path k8s \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default \
  --sync-policy automated
```


Fluxo de trabalho:
a. Um desenvolvedor faz um commit e push para o repositório GitHub.
b. O GitHub Actions é acionado, constrói a imagem Docker, faz push para o ECR e atualiza o manifesto Kubernetes com a nova tag de imagem.
c. O ArgoCD detecta a mudança no repositório e aplica automaticamente as alterações no cluster EKS.

Este fluxo automatiza o processo de deploy de ponta a ponta, desde o commit do desenvolvedor até a entrega no cluster EKS.
