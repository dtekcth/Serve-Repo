FROM caddy:2.11.7-alpine@sha256:24ec7b05bc532c7bb57f727030c5056e257ff7138b4b50460306819ff79362bd

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
