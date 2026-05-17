FROM openjdk:17
COPY . /app
WORKDIR /app
CMD ["java", "src/main/java/com/example/App.java"]
