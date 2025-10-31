# ---------- Stage 1: Build Angular App ----------
FROM node:20 AS build
ENV NG_APP_URL="https://dummyjson.com/products/1"
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --configuration=production --output-path=dist/TestEnv

# ---------- Stage 2: Nginx Server ----------
FROM nginx:1.25-alpine

# Copy the actual build output
COPY --from=build /app/dist/TestEnv /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
