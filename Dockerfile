FROM teamspeak:latest
ENV TS3SERVER_LICENSE=accept
ENV PORT=443
EXPOSE 443 9987 10011 30033

# Create writable folder for database and logs
RUN mkdir -p /tmp/ts3server && chmod -R 777 /tmp/ts3server

# Create config file
RUN echo "dbplugin=ts3db_sqlite3" > /tmp/ts3server/ts3server.ini && \
    echo "dbsqlpath=/opt/ts3server/sql/" >> /tmp/ts3server/ts3server.ini && \
    echo "dbsqlcreatepath=/opt/ts3server/sql/create_sqlite/" >> /tmp/ts3server/ts3server.ini && \
    echo "dbpluginparameter=/tmp/ts3server/ts3server.sqlitedb" >> /tmp/ts3server/ts3server.ini && \
    echo "logpath=/tmp/ts3server/logs" >> /tmp/ts3server/ts3server.ini

# Create a simple health check script
RUN echo '#!/bin/sh' > /healthcheck.sh && \
    echo 'while true; do' >> /healthcheck.sh && \
    echo '  echo -e "HTTP/1.1 200 OK\n\nOK" | nc -l -p ${PORT} -q 1' >> /healthcheck.sh && \
    echo 'done' >> /healthcheck.sh && \
    chmod +x /healthcheck.sh

# Start health check server in background, then TeamSpeak
CMD sh -c "/healthcheck.sh & ts3server inifile=/tmp/ts3server/ts3server.ini"
