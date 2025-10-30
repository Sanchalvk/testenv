# Stage 1: Build Angular app
FROM node:18 AS build
WORKDIR /app 

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy environment and source code
COPY . .

# Build Angular app (uses .env if your app supports it)
RUN npm run build --configuration=production --output-path=dist/app

# Stage 2: NGINX serve
FROM nginx:1.25-alpine

# Copy build output
COPY --from=build /app/dist/app /usr/share/nginx/html

# Copy .env file into container (for runtime use or debugging)
COPY .env /usr/share/nginx/html/.env

# Optional: custom Nginx config
# COPY nginx
