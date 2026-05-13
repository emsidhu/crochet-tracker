FROM maven:4.0.0-rc-5-eclipse-temurin-25-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests 

FROM eclipse-temurin:25.0.1_8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/crochet-tracker-0.0.1-SNAPSHOT.jar crochet-tracker.jar 
EXPOSE 8080 
ENTRYPOINT [ "java","-jar","crochet-tracker.jar" ]