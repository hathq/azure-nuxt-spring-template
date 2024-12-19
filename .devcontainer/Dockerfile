FROM mcr.microsoft.com/devcontainers/base:latest

# 開発環境で必要なツールをインストール
# Node.js, NPM, Java 17, Maven, Docker CLI, Azure CLI など

# Node.js (Using nvm)
RUN apt-get update && apt-get install -y curl build-essential git \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Java 17 (Temurin or default-jdk)
RUN apt-get update && apt-get install -y openjdk-21-jdk maven

# Docker CLI
RUN apt-get update && apt-get install -y docker.io

# Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# ユーザーvscodeでログイン
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

# vscodeユーザ作成 (devcontainersベースイメージはすでにユーザ作成済みが多い)
# 念のため確認
RUN groupadd --gid $USER_GID $USERNAME || true
RUN useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME || true

USER $USERNAME

WORKDIR /workspaces

# 設定はdevcontainer.jsonで行われるのでここでは最低限
