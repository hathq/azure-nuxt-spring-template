# ビルドステージ：Node 18 Alpineベース
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build # NuxtのSSG出力: .output/public

# 実行ステージ：Nginx Alpineイメージ
FROM nginx:alpine
COPY --from=builder /app/.output/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
