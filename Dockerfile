
# Stage 1: Build the Maven project
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

# Compile the project and run JUnit tests
RUN mvn clean package

# Stage 2: Run the application
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/target/mavenn-1.0-SNAPSHOT.jar app.jar

# Start the Parking application
CMD ["java", "-cp", "app.jar", "com.example.mavenn.Parking"]
