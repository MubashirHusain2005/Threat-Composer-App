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

RUN mkdir -p /var/cache/nginx /var/run /usr/share/nginx/html \
    && chown -R appuser:appgroup /var/cache/nginx /var/run /usr/share/nginx/html

RUN touch /var/run/nginx.pid 
RUN  chown -R appuser:appgroup /var/run/nginx.pid /var/run

COPY nginx.conf /etc/nginx/conf.d/default.conf

USER appuser

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
