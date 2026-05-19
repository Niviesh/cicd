FROM eclipse-temurin:17-jre-alpine
ARG artifact=target/demo-app-1.0.jar
WORKDIR /opt/app
COPY ${artifact} app.jar
ENTRYPOINT ["java","-jar","app.jar"]
