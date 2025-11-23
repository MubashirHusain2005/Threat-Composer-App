# Stage 1: Build
FROM node:24-alpine AS builder

WORKDIR /app

COPY package.json yarn.lock tsconfig.json ./


RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

RUN rm -rf src/ tsconfig.json


# Stage 2: Production

FROM nginx:alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN rm -rf /usr/share/nginx/html/*

USER appuser

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

#NGINX used as a server to run my HTML AND JS files
CMD ["nginx", "-g" , "daemon off;"] 
