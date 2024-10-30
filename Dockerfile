# Stage #1, Build dvja in openjdk container
FROM openjdk:8 AS build
RUN apt-get update && \
	apt-get install -y maven git
	
WORKDIR /app
RUN git clone https://github.com/appsecco/dvja.git /app
RUN mvn dependency:resolve
RUN mvn clean package

# Stage #2, Deploy dvja in Tomcat server in alpine container
FROM alpine:latest
RUN apk update && apk upgrade && \
	apk add bash && \
	apk add tar && \
	apk add openjdk8-jre-base && \
	apk add curl && \
	apk add mysql-client && \
	apk add maven
RUN curl https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68.tar.gz --output tomcat.tar.gz
RUN mkdir /opt/tomcat
RUN tar xvzf tomcat.tar.gz --strip-components 1 --directory /opt/tomcat

WORKDIR /opt
COPY --from=build /app/db/ /opt/db/
COPY start.sh start.sh
COPY --from=build /app/target/*.war /opt/tomcat/webapps/dvja.war

EXPOSE 8080
CMD ["sh", "/opt/start.sh"]
