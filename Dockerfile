FROM caddy:2.11.8-alpine@sha256:eb37f58646a901dc7727cf448cae36daaefaba79de33b5058dab79aa4c04aefb

RUN apk update && apk add \
      git \
      gettext
WORKDIR /usr/share/caddy/html
COPY Caddyfile_template /Caddyfile_template
COPY runner.sh /runner.sh

ENV SUBDIR /
ENV FILE_SERVER_CFG ""
ENV SERVER_CFG ""
ENV INTERVAL 3600

# NB: exec is vital to forward signals to the runner
CMD exec sh /runner.sh
