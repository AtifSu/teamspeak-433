FROM teamspeak
ENV TS3SERVER_LICENSE=accept
EXPOSE 443
CMD ["ts3server", "default_voice_port=443", "query_port=10011", "filetransfer_port=30033", "voice_ip=0.0.0.0"]
