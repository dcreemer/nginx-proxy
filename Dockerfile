FROM alpine:3.4

RUN apk add --update ca-certificates openssl nginx supervisor

# install docker-gen
ENV DOCKER_GEN_VERSION 0.7.3
ENV DOCKER_GEN_TARFILE docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz
RUN wget -q -O - https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/$DOCKER_GEN_TARFILE | \
    tar -C /usr/local/bin -xvzf -

RUN apk del wget && \
    rm -rf /var/cache/apk/* && \
    mkdir /app

ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME ["/etc/nginx/certs"]

COPY nginx /etc/nginx/
COPY supervisord.conf nginx.tmpl app/

CMD ["supervisord", "-n", "-c", "/app/supervisord.conf"]
