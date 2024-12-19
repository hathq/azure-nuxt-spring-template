## 初期セットアップ手順

このドキュメントでは、本テンプレートリポジトリをクローンまたは「Use this template」機能で新規作成したリポジトリにおける初期セットアップ方法を示します。

### 前提条件

- Azureサブスクリプションを保有していること  
- Azure CLI、GitHub アカウントへのアクセス権  
- Nuxt.js、Java、Maven、Dockerなどの基本的な知識

### 手順

1. **リポジトリの作成**  
   GitHub上で本テンプレートを用いて新規リポジトリを作成します。

2. **Azureでの準備**  
   - AzureでサービスプリンシパルまたはOIDCフェデレーション用の設定を行い、GitHub ActionsからAzureにログインできるようにします。  
   - [SECURITY.md](SECURITY.md)を参照し、必要なロール割り当てやFederated Credentialsを設定してください。

3. **パラメータファイルの確認・変更**  
   `infra/parameters/dev.json`などの環境別パラメータファイルを確認し、適切なリソース名、SKU、リージョンを設定してください。  
   開発環境なら`dev.json`を調整し、`prod`環境では`prod.json`を修正します。

4. **ローカルでのビルド確認(任意)**  

   フロントエンド:  
   ```bash
   cd frontend
   npm ci
   npm run build
   ```

   バックエンド:  
   ```bash
   cd backend
   mvn clean package -DskipTests=false
   ```

特に問題がなければ、ローカルビルドは成功です。

5. **GitHub Actionsの実行**

   - リポジトリのActionsタブからInfra Deployワークフローを手動トリガーし、dev環境向けインフラをデプロイします。
   - デプロイが完了したら、CI/CD BackendやCI/CD Frontendワークフローがpush時に自動的に実行され、アプリケーションがデプロイされます。

6. **ブラウザでの動作確認**

   - App ServiceのURL(例: https://myapp-frontend-dev.azurewebsites.net)へアクセスし、フロントエンドが表示されること、バックエンドへのAPIコールが正常に動作することを確認します。

### トラブルシューティング

   - デプロイ失敗時: Azure CLIのログやGitHub Actionsログを参照
   - 接続文字列不明の場合: Key Vaultで管理されていることを確認
   - OIDCが機能しない場合: Azure PortalでFederated Credentialが正しく設定されているか再確認

これで初期セットアップは完了です。