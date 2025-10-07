FROM eclipse-temurin:21-jre AS run

EXPOSE 65535

RUN mkdir -p /server
WORKDIR /server

# Copy entrypoint to a safe place outside the volume
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# /server can now safely be a volume mount
VOLUME /server

ENTRYPOINT ["/entrypoint.sh"]
