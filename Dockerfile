FROM eclipse-temurin:17-jre
WORKDIR /app
# Copy built jar (the wildcard handles versioned jar names)
COPY ./target/*.jar app.jar
EXPOSE 8080
ENV JAVA_OPTS=""
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app.jar"]
