FROM martinussuherman/alpine:3.13-amd64-glibc

# Definir a versão do code-server
ENV VERSION=3.12.0

# Instalar dependências
RUN apk --no-cache --update add \
    curl \
    git \
    gnupg \
    nodejs \
    openssh-client \
    fuse3 \
    rclone

# Adicionar o usuário vscode
RUN adduser -D -s /bin/ash vscode

# Definir permissões corretas
RUN chown -R vscode:vscode /home/vscode

# Instalar code-server
RUN wget https://github.com/coder/code-server/releases/download/v$VERSION/code-server-$VERSION-linux-amd64.tar.gz && \
    tar xzf code-server-$VERSION-linux-amd64.tar.gz && \
    mv code-server-$VERSION-linux-amd64 /usr/lib/code-server && \
    ln -s /usr/lib/code-server/bin/code-server /usr/bin/code-server && \
    rm code-server-$VERSION-linux-amd64.tar.gz && \
    chmod +x /usr/bin/code-server && \
    sed -i 's/"$ROOT\/lib\/node"/node/g' /usr/lib/code-server/bin/code-server

# Definir o usuário e diretório de trabalho
USER vscode
WORKDIR /home/vscode

# Expor a porta para o code-server
EXPOSE 8080
ENTRYPOINT ["entrypoint-su-exec", "code-server"]
# Comando padrão para o code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none"]
