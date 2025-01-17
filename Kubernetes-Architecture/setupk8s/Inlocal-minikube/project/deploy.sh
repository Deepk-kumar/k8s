#!/bin/bash

# Run the frontend container
sudo docker run -d --name springboot-react-mysql-frontend \
  -p 3000:80 \
  deeppaakk/springboot-react-mysql_frontend:latest

# Run the MySQL database container
sudo docker run -d --name springboot-react-mysql-db \
  --env-file .env \
  -p 3306:3306 \
  deeppaakk/mysql:5.7

# Run the backend container
sudo docker run -d --name springboot-react-mysql-backends \
  -p 8080:8080 \
  --link springboot-react-mysql-db:mysql \
  --env-file .env \
  deeppaakk/springboot-react-mysql_backend:latest

# Print the status of all containers
sudo docker ps
