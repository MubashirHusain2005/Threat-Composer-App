# Stage 1: Build
FROM node:24-alpine AS builder

WORKDIR /app

COPY package.json yarn.lock tsconfig.json ./
RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

RUN rm -rf src/ tsconfig.json


# Stage 2: Production with standard nginx
FROM nginx:alpine

# Create non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Create directories Nginx needs and make them writable
RUN mkdir -p /var/cache/nginx /var/run /usr/share/nginx/html \
    && chown -R appuser:appgroup /var/cache/nginx /var/run /usr/share/nginx/html \
    && chmod -R 755 /var/cache/nginx /var/run /usr/share/nginx/html

# Switch to non-root user
USER appuser

# Copy React build from builder
COPY --from=builder /app/build /usr/share/nginx/html

# Expose non-privileged port
EXPOSE 8080

COPY nginx.conf etc/nginx/conf.d/default.conf

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
