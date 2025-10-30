# ---------- Stage 1: Build Angular App ----------
FROM node:18 AS build

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build --configuration=production --output-path=dist/app

# ---------- Stage 2: Nginx Server ----------
FROM nginx:1.25-alpine

# Copy built files
COPY --from=build /app/dist/app /usr/share/nginx/html

# Copy .env if present
# (Make sure .env exists and isn’t in .dockerignore)
COPY .env /usr/share/nginx/html/.env

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
