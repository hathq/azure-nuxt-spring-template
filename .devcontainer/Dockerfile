FROM mcr.microsoft.com/devcontainers/base:latest

# 開発環境で必要なツールをインストール
# Node.js, NPM, Java 21, Maven, Docker CLI, Azure CLI など

# Node.js (Using nvm)
RUN apt-get update && apt-get install -y curl build-essential git \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest yarn nuxt

# Eclipse Temurin JDK 21 (Adoptium) ダウンロード & インストール
RUN curl -fsSL "https://api.adoptium.net/v3/binary/latest/21/ga/linux/x64/jdk/hotspot/normal/eclipse?project=jdk" -o /tmp/jdk21.tar.gz \
    && mkdir /opt/jdk-21 \
    && tar xf /tmp/jdk21.tar.gz -C /opt/jdk-21 --strip-components=1 \
    && rm /tmp/jdk21.tar.gz \
    && update-alternatives --install /usr/bin/java java /opt/jdk-21/bin/java 1 \
    && update-alternatives --install /usr/bin/javac javac /opt/jdk-21/bin/javac 1

# Mavenをインストール
RUN apt-get update && apt-get install -y maven \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# JAVA_HOMEをJDK21のディレクトリに設定
ENV JAVA_HOME=/opt/jdk-21
ENV PATH="$JAVA_HOME/bin:${PATH}"

# Docker CLI
RUN apt-get update && apt-get install -y docker.io

# Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /workspaces

# 設定はdevcontainer.jsonで行われるのでここでは最低限
