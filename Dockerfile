FROM eclipse-temurin:17-jre
ARG HOME="/apps"
ARG ID="backend"
ARG JAR_FILE=target/*.jar
ENV JAVA_OPTS ""
RUN addgroup ${ID} && adduser --disable-password --ingroup ${ID} --home ${HOME} --gecos "" ${ID} 
WORKDIR ${HOME}
COPY --chown=${ID} ${JAR_FILE} ${HOME}/app.jar
CMD java -jar $JAVA_OPTS app.jar
