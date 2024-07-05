# Use uma imagem base com Python 3.9.5
FROM python:3.9.5-slim

# Instale dependências necessárias
RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    curl \
    unzip

# Instale o Microsoft Edge
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/microsoft-edge.list && \
    apt-get update && \
    apt-get install -y microsoft-edge-stable

# Baixe o Edge WebDriver
RUN EDGE_DRIVER_VERSION=$(curl -s https://msedgewebdriverstorage.blob.core.windows.net/edgewebdriver/LATEST_RELEASE) && \
    wget -O /tmp/edgedriver.zip "https://msedgewebdriverstorage.blob.core.windows.net/edgewebdriver/$EDGE_DRIVER_VERSION/edgedriver_linux64.zip" && \
    unzip /tmp/edgedriver.zip -d /usr/local/bin/ && \
    rm /tmp/edgedriver.zip

# Configurar diretório de trabalho
WORKDIR /app

# Copie os arquivos necessários para o container
COPY . /app

# Instale as dependências do Python
RUN pip install --no-cache-dir -r requirements.txt

# Configuração de entrada para o script de teste
ENTRYPOINT ["python", "test_script.py"]
