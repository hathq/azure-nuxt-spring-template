# infra ディレクトリについて

このディレクトリには、Azure上のインフラストラクチャをBicepで定義したファイルと、各環境(dev, stg, prod)向けのパラメータファイルが含まれています。

## 主なファイル

- `main.bicep`:  
  各種モジュールを呼び出して、Resource GroupやACR、App Service、Cosmos DB、Key Vault、App Configuration、Application Insightsなどを一括でデプロイ。

- `modules/`:  
  リソース種類ごとのBicepファイルを格納。`main.bicep`からこれらをモジュールとして呼び出します。

- `parameters/`:  
  `dev.json`, `stg.json`, `prod.json`など、環境ごとの設定値(名前、SKU、リージョン)を記述したパラメータファイル。

## デプロイ手順

ローカルでのデプロイ例:

```bash
az login
az group create --name "myapp-rg-dev" --location "japaneast"
az deployment group create \
  --resource-group "myapp-rg-dev" \
  --template-file ./main.bicep \
  --parameters @parameters/dev.json
```

GitHub Actionsを使用する場合、infra-deploy.ymlワークフローを手動トリガーし、environmentを指定することで上記と同等の処理を実行します。

## カスタマイズ方法

- 新たなリソースを追加したい場合：
  modules/ディレクトリに該当リソース用のBicepファイルを作成し、main.bicepにモジュールとして追加します。

- 環境ごとの設定調整：
  parameters/配下のファイルでSKUやリソース名接頭辞、場所を変更可能。
  これにより、dev/stg/prodなど異なる環境へ簡易に展開できます。

以上により、infraディレクトリはインフラ構築の自動化と環境管理に役立ちます。
