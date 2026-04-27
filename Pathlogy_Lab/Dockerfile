# Build stage
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Run stage
FROM tomcat:10.1-jdk21-temurin-jammy
WORKDIR /usr/local/tomcat/webapps/
# Remove default webapps
RUN rm -rf ROOT && rm -rf examples && rm -rf docs
# Copy the WAR file from the build stage
COPY --from=build /app/target/Pathlogy_Lab-0.0.1-SNAPSHOT.war ./ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
