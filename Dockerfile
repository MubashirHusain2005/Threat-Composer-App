
# Stage 1: Build
FROM node:24-alpine AS builder

# Set working directory
WORKDIR /app

# Only copy package files first 
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy only source code and essential files
COPY . .

# Build the app 
RUN yarn build

# Stage 2: Production

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

# Copy only the build output + necessary files
COPY --from=builder /app/build /usr/share/nginx/html

# Expose the port
EXPOSE 80

# Run the app
CMD ["nginx", "-g" , "daemon off;"]
