FROM node:14 AS builder
WORKDIR /app
COPY . .
RUN yarn install --network-timeout 1000000 && yarn build
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/public .
ENTRYPOINT ["nginx", "-g", "daemon off;"]