FROM maven:3-ibmjava-8-alpine AS builder
COPY  ./ /usr/src/app/
RUN test -d /usr/src/app/.m2 && { mv -f /usr/src/app/.m2 /root/ } || /bin/true
WORKDIR /usr/src/app/
RUN mvn package

FROM tomcat:9-jdk11-openjdk-slim
COPY --from=builder /usr/src/app/target/mongodb-slow-operations-profiler.war /usr/local/tomcat/webapps/
RUN chown -R nobody /usr/local/tomcat/webapps/
USER nobody
