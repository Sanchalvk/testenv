# ---------- Stage 1: Build Angular App ----------
FROM node:18 AS build

WORKDIR /app

# Copy package files and install deps
COPY package*.json ./
RUN npm install   # ← replace npm ci with npm install

# Copy source and build Angular app
COPY . .
RUN npm run build --configuration=production --output-path=dist/app

# ---------- Stage 2: Nginx Server ----------
FROM nginx:1.25-alpine
COPY --from=build /app/dist/app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
