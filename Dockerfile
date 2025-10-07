FROM teamspeak:latest
ENV TS3SERVER_LICENSE=accept
ENV PORT=443
EXPOSE 443
EXPOSE 10011

# Install Python3 for health check server (Alpine uses apk)
RUN apk add --no-cache python3

# Create writable folder for database and logs
RUN mkdir -p /tmp/ts3server && chmod -R 777 /tmp/ts3server

# Create config file
RUN echo "dbplugin=ts3db_sqlite3" > /tmp/ts3server/ts3server.ini && \
    echo "dbsqlpath=/opt/ts3server/sql/" >> /tmp/ts3server/ts3server.ini && \
    echo "dbsqlcreatepath=/opt/ts3server/sql/create_sqlite/" >> /tmp/ts3server/ts3server.ini && \
    echo "dbpluginparameter=/tmp/ts3server/ts3server.sqlitedb" >> /tmp/ts3server/ts3server.ini && \
    echo "logpath=/tmp/ts3server/logs" >> /tmp/ts3server/ts3server.ini

# Start both TeamSpeak and a health check HTTP server
CMD sh -c "python3 -m http.server ${PORT} & ts3server inifile=/tmp/ts3server/ts3server.ini default_voice_port=9987"
