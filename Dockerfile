FROM gradle:jdk21-alpine AS build
COPY . /workdir
WORKDIR /workdir
RUN gradle shadowJar

FROM eclipse-temurin:21-jre AS run

EXPOSE 65535
RUN mkdir /server
WORKDIR /server
VOLUME /server

COPY --from=build /workdir/build/libs/*.jar /server/NanoLimbo.jar

ENTRYPOINT ["java", "-jar", "/server/NanoLimbo.jar"]
