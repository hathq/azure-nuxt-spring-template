# INFRA.md

## インフラ構成

このドキュメントでは、`infra/`ディレクトリで定義されたAzureインフラ構成の概要と、パラメータファイルによるカスタマイズ方法を説明します。

### 概要

`infra/main.bicep` は、以下のAzureリソースを一括デプロイします。

- Resource Group  
- Azure Container Registry (ACR)  
- App Service Plan & App Service (Frontend/Backend用)  
- Cosmos DB (SQL API)  
- Key Vault  
- App Configuration  
- Application Insights

### モジュール構造

`infra/modules/`配下に各リソース定義をモジュール単位で分割しています。`main.bicep`がこれらを呼び出し、パラメータによる条件分岐や命名規則反映が行われます。

例:  
```bicep
module rg 'modules/resourceGroup.bicep' = {
  name: 'rgDeployment'
  params: {
    rgName: 'myapp-rg-dev'
    location: 'japaneast'
  }
}
