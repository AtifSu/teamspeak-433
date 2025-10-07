FROM teamspeak:latest
ENV TS3SERVER_LICENSE=accept
EXPOSE 443

# Create writable folder for database and logs
RUN mkdir -p /tmp/ts3server && chmod -R 777 /tmp/ts3server

# Create a simple config file that points to writable paths
RUN echo "dbplugin=ts3db_sqlite3" > /tmp/ts3server/ts3server.ini && \
    echo "dbsqlpath=/opt/ts3server/sql/" >> /tmp/ts3server/ts3server.ini && \
    echo "dbsqlcreatepath=/opt/ts3server/sql/create_sqlite/" >> /tmp/ts3server/ts3server.ini && \
    echo "dbpluginparameter=/tmp/ts3server/ts3server.sqlitedb" >> /tmp/ts3server/ts3server.ini && \
    echo "logpath=/tmp/ts3server/logs" >> /tmp/ts3server/ts3server.ini

# Explicitly set the voice port to 443
CMD ["ts3server", "inifile=/tmp/ts3server/ts3server.ini", "default_voice_port=443"]
