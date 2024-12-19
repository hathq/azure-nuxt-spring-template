# Azure Service Template

このリポジトリは、Azure上でNuxt.jsフロントエンド、Spring Bootバックエンド、Cosmos DBを用いたフルスタックアプリケーションを迅速に構築・運用するためのテンプレートです。  
さらに、Bicepによるインフラ自動構築、GitHub ActionsによるCI/CD、Key Vaultによるシークレット管理、軽量コンテナイメージを用いたパフォーマンス最適化といった共通基盤機能を包含しています。

## 主な特徴

- **フロントエンド**: Nuxt.js (SSG対応)  
- **バックエンド**: Spring Boot (Java 17), Cosmos DB接続対応  
- **インフラ定義**: BicepによるIaCでResource Group, ACR, App Service, Cosmos DB, Key Vault, App Config, App Insightsを一括デプロイ  
- **CI/CD**: GitHub Actionsを使用した、自動ビルド・テスト・デプロイパイプライン  
- **セキュリティ**: Key Vault, Managed Identity, OIDCフェデレーションでシークレットレスな安全性確保  
- **パフォーマンス**: Alpineベース・マルチステージビルドを用いた軽量コンテナイメージ化

## 使い方

1. GitHub上で「Use this template」を用いて本リポジトリを新規作成  
2. `docs/SETUP.md` を参照して、Azure資格情報やパラメータを設定  
3. GitHub Actionsワークフローを実行してインフラ構築、アプリデプロイ  
4. アプリケーションがApp Service上で動作開始

詳細は `docs/` ディレクトリ内のドキュメントをご参照ください。

## ドキュメント一覧

- [docs/SETUP.md](docs/SETUP.md): 初期セットアップ手順  
- [docs/INFRA.md](docs/INFRA.md): インフラ構成・パラメータ定義  
- [docs/CI_CD.md](docs/CI_CD.md): CI/CDワークフロー詳細  
- [docs/SECURITY.md](docs/SECURITY.md): セキュリティ・認証関連設定  
- [docs/PERFORMANCE.md](docs/PERFORMANCE.md): パフォーマンス最適化手法
