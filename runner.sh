#! /bin/sh

# Clone repo if not done already
if ! git status > /dev/null 2>&1
then
  git clone --depth 1 "$GIT_REPO" . || exit 1
fi

# Generate and verify caddy config
envsubst < /Caddyfile_template > /etc/caddy/Caddyfile
caddy validate --config /etc/caddy/Caddyfile|| exit 1

# Start caddy in background
caddy run --config /etc/caddy/Caddyfile &
caddyPid=$!
sleepPid=

# Forward signals to blocking processes
stop() {
  kill -s "$1" "$caddyPid"
  if test "$1" != "SIGHUP"
  then
    # We're expecting caddy to stop
    wait "$caddyPid"
  fi
  kill -s "$1" "$sleepPid"
}

trap 'stop SIGHUP' SIGHUP
trap 'stop SIGINT' SIGINT
trap 'stop SIGQUIT' SIGQUIT
trap 'stop SIGTERM' SIGTERM

# While caddy is running
while kill -0 "$caddyPid"
do
  git pull
  git submodule update --init --recursive
  sleep "$INTERVAL" &
  sleepPid=$!
  wait "$sleepPid"
done
