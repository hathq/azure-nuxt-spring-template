# ビルドステージ：Node 18 Alpineベース
FROM node:23.4-alpine3.21 AS build
WORKDIR /app

# package.jsonとyarn.lockを先にCOPYしてyarn install (キャッシュの有効活用)
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# ソースコードコピー
COPY . .

# Nuxt3 SSGビルド（.output/publicに静的ファイル出力）
RUN yarn build

# 実行ステージ：Nginx Alpineイメージ
FROM nginx:alpine
COPY --from=builder /app/.output/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
