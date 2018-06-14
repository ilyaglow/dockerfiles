FROM maven:3.5-jdk-8 as builder
LABEL link=https://github.com/frohoff/ysoserial \
      maintainer="Ilya Glotov <ilya@ilyaglotov.com>"

RUN git clone --branch=master \
              --depth=1 \
              https://github.com/frohoff/ysoserial \
  && cd /ysoserial \
  && mvn dependency:resolve \
  && mvn verify \
  && mvn clean package -DskipTests \
  && mv target/ysoserial-*all*.jar target/ysoserial.jar

FROM openjdk:8-alpine

COPY --from=builder /ysoserial/target/ysoserial.jar .

RUN adduser -D ysoserial

USER ysoserial

ENTRYPOINT ["java", "-jar", "ysoserial.jar"]
