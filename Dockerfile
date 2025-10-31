# Use Eclipse Temurin JRE 17 as the base image
FROM eclipse-temurin:17-jre

# Define build arguments
ARG HOME=/apps
ARG ID=backend
ARG JAR_FILE=target/*.jar

# Set environment variables
ENV JAVA_OPTS=""

# Create user and group
RUN addgroup --system ${ID} && adduser --system --ingroup ${ID} --home ${HOME} ${ID}

# Set working directory
WORKDIR ${HOME}

# Copy the JAR file into the container and set ownership
COPY --chown=${ID}:${ID} ${JAR_FILE} app.jar

# Switch to the non-root user
USER ${ID}

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
