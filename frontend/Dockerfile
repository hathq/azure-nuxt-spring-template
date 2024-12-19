# ビルドステージ：Node 18 Alpineベース
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json .
COPY . .
RUN yarn build # NuxtのSSG出力: .output/public

# 実行ステージ：Nginx Alpineイメージ
FROM nginx:alpine
COPY --from=builder /app/.output/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
