# Multi-stage Dockerfile for Java 21 Question Bank Tomcat Webapp
FROM maven:3.9-eclipse-temurin-26 AS builder
WORKDIR /workspace
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jre21 AS runtime
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /workspace/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
