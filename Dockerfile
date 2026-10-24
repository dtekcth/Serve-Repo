FROM caddy:2.11.7-alpine@sha256:eb4d35b7452d1ab6171fbdbe8d9275b2301dad6dad92115d91e19fb9b24d510f

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
