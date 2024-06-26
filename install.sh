#!/bin/bash

# Nome da imagem
IMAGE_NAME="meu-app"

# Caminho para o Dockerfile
DOCKERFILE_PATH="./amd64/Dockerfile"

# Construir a imagem Docker a partir do Dockerfile
docker build -t $IMAGE_NAME -f $DOCKERFILE_PATH .

# Verificar se a imagem foi construída com sucesso
if [ $? -eq 0 ]; then
  echo "Imagem construída com sucesso."

  # Executar o contêiner a partir da imagem construída com as flags adicionais
  docker run --device /dev/fuse --cap-add SYS_ADMIN -p 8080:8080 $IMAGE_NAME

  # Verificar se o contêiner foi iniciado com sucesso
  if [ $? -eq 0 ]; then
    echo "Contêiner iniciado com sucesso."
  else
    echo "Falha ao iniciar o contêiner."
  fi
else
  echo "Falha ao construir a imagem."
fi
