# CI_CD.md

## CI/CDパイプライン概要

このリポジトリでは、GitHub Actionsを用いてCI/CDを実現します。プッシュやプルリク時に自動でテスト・ビルド・デプロイが行われ、インフラ変更もワークフローから適用可能です。

### フロントエンド (ci-cd-frontend.yml)

- **トリガー**: `main`ブランチへのプッシュ  
- **処理内容**:  
  1. コードチェックアウト  
  2. Node.js (Alpine)環境で依存関係インストール・テスト・ビルド  
  3. Dockerイメージ化 (マルチステージビルド)  
  4. ACRプッシュ・App Serviceへデプロイ

### バックエンド (ci-cd-backend.yml)

- **トリガー**: `main`ブランチへのプッシュ  
- **処理内容**:
  1. コードチェックアウト  
  2. Maven依存関係キャッシュ＆AlpineベースJDKでビルド・テスト  
  3. Dockerマルチステージビルドで軽量ランタイムイメージ作成  
  4. ACRへプッシュ  
  5. Azure App Serviceへデプロイ

### インフラデプロイ (infra-deploy.yml)

- **トリガー**: 手動 (workflow_dispatch)  
- **処理内容**:
  1. コードチェックアウト  
  2. OIDCを用いてAzureへログイン  
  3. `main.bicep` + パラメータファイルでBicepデプロイ実行  
  4. Resource Groupや各リソースの作成・更新

### 環境別デプロイ

`infra-deploy.yml`で`environment`入力を受け取り、`dev.json`や`prod.json`など異なるパラメータでデプロイ可能です。これにより、開発/ステージング/本番環境を切り替えられます。

### ローカル実行

ローカルで`docker build`や`mvn package`でテスト可能。問題なければGitHub Actions上でも同様に動作します。

### 拡張

- テストカバレッジツールやLintを追加  
- Blue-Greenデプロイやスロットデプロイ活用  
- Dependabotで依存ライブラリ自動更新

以上がCI/CDの概要です。
