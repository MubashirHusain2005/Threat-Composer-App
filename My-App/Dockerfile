# Stage 1: Build
FROM node:24-alpine AS builder

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app


COPY --chown=appuser:appgroup package.json yarn.lock ./
RUN yarn install --frozen-lockfile

 
COPY --chown=appuser:appgroup . .
RUN yarn build



RUN rm -rf src/ tsconfig.json


# Stage 2: Production

FROM nginx:alpine
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN mkdir -p /usr/share/nginx/html && chown -R appuser:appgroup /usr/share/nginx/html
RUN chmod -R 755 /usr/share/nginx/html

USER appuser

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

#NGINX used as a server to run my HTML AND JS files
CMD ["nginx", "-g" , "daemon off;"] 
