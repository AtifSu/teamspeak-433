FROM teamspeak
ENV TS3SERVER_LICENSE=accept
EXPOSE 443
CMD sh -c "mkdir -p /tmp/ts3db && ts3server default_voice_port=${PORT:-443} query_port=10011 filetransfer_port=30033 voice_ip=0.0.0.0 dbsqlpath=/opt/ts3server/sql/ dbplugin=ts3db_sqlite3 dbsqlcreatepath=/opt/ts3server/sql/create_sqlite/ dbpath=/tmp/ts3db/"
