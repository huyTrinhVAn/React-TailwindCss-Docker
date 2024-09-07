# Stage 1: Build stage
FROM node:20.16.0-alpine AS build

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy package.json và package-lock.json
COPY package*.json ./

# Cài đặt dependencies
RUN npm install

# Copy mã nguồn vào container
COPY . .

# Build ứng dụng
RUN npm run build

# Stage 2: Serve stage
FROM nginx:alpine

# Copy các file đã build từ build stage sang thư mục nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 để truy cập ứng dụng
EXPOSE 80

# Chạy nginx
CMD ["nginx", "-g", "daemon off;"]
