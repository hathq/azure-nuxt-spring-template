# ビルドステージ：Node 18 Alpineベース
FROM node:22-alpine AS builder
WORKDIR /app
COPY . .
RUN yarn install && yarn build

# 実行ステージ：Nginx Alpineイメージ
FROM nginx:alpine
COPY --from=builder /app/.output/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
