FROM caddy:2.11.9-alpine@sha256:003a97808e781aa9f7e75cc2f43d34d461099031faf5e20faefb9f61126836f0

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
