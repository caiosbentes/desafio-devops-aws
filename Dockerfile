# Usando uma imagem base do Python
FROM python:3.9-slim

# Definir o diretório de trabalho
WORKDIR /app

# Copiar os requisitos e instalar dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar a aplicação
COPY src/app.py .

# Expor a porta em que a aplicação vai rodar
EXPOSE 5000

# Comando para iniciar a aplicação
CMD ["flask", "run", "--host", "0.0.0.0"]
