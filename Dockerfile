# Multi-stage Docker build for Phonebook Spring Boot Backend
# Stage 1: Build JAR with Maven & Eclipse Temurin JDK 21
FROM maven:3.9.6-eclipse-temurin-21-jammy AS builder

WORKDIR /build

# Copy POM and download dependencies to leverage Docker cache
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and package application skipping unit tests during image build
COPY src ./src
RUN mvn clean package -DskipTests -B

# Stage 2: Runtime image with minimal JRE footprint
FROM eclipse-temurin:21-jre-jammy

# Create non-privileged system user for security
RUN groupadd -r phonebook && useradd -r -g phonebook -s /bin/false phonebook

WORKDIR /app

# Copy the built jar from builder stage
COPY --from=builder /build/target/*.jar app.jar

# Give phonebook user ownership
RUN chown -R phonebook:phonebook /app

USER phonebook

# Expose server port (default 8080 or overridden by Render's $PORT)
EXPOSE 8080

# Environment variables defaults (can be overridden by Render environment variables)
ENV PORT=8080 \
    SPRING_PROFILES_ACTIVE=prod \
    JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC -XX:+ExitOnOutOfMemoryError"

# Start application using exec form
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar app.jar"]
