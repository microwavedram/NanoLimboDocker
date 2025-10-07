FROM eclipse-temurin:21-jre AS run

EXPOSE 65535
RUN mkdir -p /server
WORKDIR /server

COPY entrypoint.sh /server/entrypoint.sh
RUN chmod +x /server/entrypoint.sh

ENTRYPOINT ["/server/entrypoint.sh"]