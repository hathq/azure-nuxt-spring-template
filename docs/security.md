# SECURITY.md

## 概要

このドキュメントでは、AzureおよびGitHub Actionsを用いた本プロジェクトのセキュリティ対策や設計について説明します。  
以下は、シークレット管理、認証・認可、環境別の設定管理、ネットワーク保護など、多面的なセキュリティ確保手法を取り上げています。

## シークレット管理

### Key Vault

- **Key Vaultの利用**:  
  Azure Key Vaultは機密情報（DB接続文字列、APIキー、証明書など）を安全に格納するために使用します。  
  Managed Identityを利用すれば、アプリケーションはキーやシークレットをコードに直書きせず、安全に取得可能です。

- **参照方法**:  
  アプリケーション（App Service）はManaged Identityを介してKey Vaultへアクセスし、キーやシークレットを取得します。これにより、資格情報をCI/CDパイプラインやコード内で扱う必要がありません。

### GitHub Secretsの取り扱い

- **リポジトリシークレット**:  
  環境に依存せず、すべての環境（dev/stg/prod）で共通となるID・テナントID・サブスクリプションIDなどはリポジトリシークレットとして定義します。  
  例：`AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`

- **環境シークレット**:  
  Cosmos DB接続文字列やKey Vaultへの特定環境用アクセストークンなど、環境固有のシークレットはGitHub ActionsのEnvironment機能を用いて環境シークレットとして設定します。  
  例えば、`dev`環境、`stg`環境、`prod`環境ごとに異なるCosmos DBキーやApp Configuration接続文字列をEnvironmentシークレットに定義します。  
  例：  
  - `COSMOSDB_CONNECTION_STRING_DEV` (dev環境用)  
  - `COSMOSDB_CONNECTION_STRING_STG` (stg環境用)  
  - `COSMOSDB_CONNECTION_STRING_PROD` (prod環境用)

- **ログ出力やecho禁止**:  
  シークレットは`run`ステップで`echo`したり標準出力しないでください。`azure/login@v1`などのアクションで`with:`オプションに直接指定するか、環境変数として渡す場合もログ出力は避けます。

- **承認フローの利用**:  
  環境シークレットを用いることで、GitHub Actionsの`Environments`機能による承認フローやデプロイゲートを設定できます。これにより、本番環境（prod）へのデプロイ時には特定の承認者が許可するまでシークレットを使ったデプロイ処理が実行されないようにでき、セキュリティをさらに強化します。

## OIDCフェデレーションによるAzure認証

- GitHub ActionsとAzure間でシークレットレスな認証を実現するため、OIDCフェデレーションを使用します。  
- GitHub側では`azure/login@v1`アクションで`client-id`, `tenant-id`, `subscription-id`を`secrets`コンテキストから渡します。  
- Azure Portalでリポジトリとサブスクリプション間にFederated Credentialsを設定すれば、GitHub ActionsはID/PWなしで安全にAzureへログインできます。

## Managed Identity

- App ServiceなどのAzureリソースにはManaged Identityを割り当て、Key VaultやCosmos DBへの認証を行います。  
- これにより、アプリケーションコードやCI/CDパイプラインで資格情報を扱わずにすみ、資格情報漏洩リスクを低減できます。

## Azure Active Directory (AAD) とAPI保護

- バックエンドのSpring BootアプリケーションをAADで保護し、JWTトークン認証を導入可能です。  
- フロントエンドはMSAL.jsを利用してAzure ADでログインし、取得したアクセストークンをバックエンドに渡します。

## ネットワークとアクセス制御

- App Service、Cosmos DB、Key Vaultは、パブリックアクセス制限やVNET統合、Private Endpointを利用して保護します。  
- 必要に応じてAzure Front Door、Application Gateway、WAFを追加してトラフィックをセキュアに制御可能。

## ログ・監査

- Application InsightsおよびAzure Monitorでアクセスログやテレメトリを収集・分析し、不審なアクティビティを検出。  
- Security CenterやDefender for Cloudと連携することで、脆弱性スキャンや脅威インテリジェンスを活用可能。

## 継続的なセキュリティ強化

- Dependabotによる依存パッケージの脆弱性スキャン・更新  
- CodeQLなどのSASTツールを用いてソースコードの脆弱性検出  
- 定期的なキーや証明書ローテーション

## まとめ

このドキュメントで示したとおり、環境ごとに異なるシークレットはEnvironment Secretsを、全環境共通の資格情報はRepository Secretsを用いて管理します。また、Key Vaultでのシークレット管理やManaged Identity、OIDCフェデレーションの活用により、資格情報がコードやCIログに残らない運用を実現します。

これらの仕組みを組み合わせることで、開発から本番運用までのパイプラインにおいて、強固なセキュリティ基盤を構築できます。
