FROM ubuntu:18.04

LABEL "com.github.actions.name"="WSG Backend health check Github Action"
LABEL "com.github.actions.description"="WSG Backend health check Github Action"

RUN apt-get update && apt-get install -y sshpass

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
