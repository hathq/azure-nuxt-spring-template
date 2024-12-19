# ビルドステージ：Node 22 Alpineベース
FROM node:22-alpine AS builder
WORKDIR /app

# package.jsonとyarn.lockを先にCOPYしてyarn install (キャッシュの有効活用)
COPY frontend/package.json frontend/yarn.lock ./
RUN yarn install

# ソースコードコピー
COPY frontend .

# Nuxt3 SSGビルド（distに静的ファイル出力）
RUN yarn build

# 実行ステージ：Nginx Alpineイメージ
FROM nginx:1.27.3-alpine-slim
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
