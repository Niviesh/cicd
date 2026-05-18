FROM eclipse-temurin:17-jdk-jammy
COPY . /app
WORKDIR /app
CMD ["java", "src/main/java/com/example/App.java"]
