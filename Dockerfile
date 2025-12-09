FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy jar from Maven target folder
COPY target/mavenjava-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
