FROM gradle:jdk21-alpine AS build
COPY . /workdir
WORKDIR /workdir
RUN gradle shadowJar

FROM eclipse-temurin:21-jre AS run

EXPOSE 65535
RUN mkdir /server
WORKDIR /server
VOLUME /server

RUN curl -o ./NanoLimbo.jar https://github.com/Nan1t/NanoLimbo/releases/download/v1.8.1/NanoLimbo-1.8.1-all.jar

ENTRYPOINT ["java", "-jar", "/server/NanoLimbo.jar"]
