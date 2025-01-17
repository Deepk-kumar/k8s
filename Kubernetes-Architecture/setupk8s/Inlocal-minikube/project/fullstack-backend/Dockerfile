# Stage 1: Build the application using Maven
FROM maven:3.8.6-openjdk-11-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and the source code to the container
COPY pom.xml .
COPY src ./src

# Build the application and package the JAR file
RUN mvn clean install -DskipTests

# Stage 2: Run the application using OpenJDK
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/fullstack-backend-0.0.1-SNAPSHOT.jar /app/app.jar

# Expose the port the app runs on (default Spring Boot port)
EXPOSE 8080

# Run the application using the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
