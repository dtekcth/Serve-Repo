# Serve-Repo

A docker image to serve static files from a git repo and keep them up to date.

## Usage

Run the image specifying `GIT_REPO` and optionally aditional environment
variables. All avalable are specified below:

| Name              | Default | Description                              |
|-------------------|---------|------------------------------------------|
| `GIT_REPO`        |         | Url of git repo to clone                 |
| `SUBDIR`          | /       | Subdirectory to serv from e.g. `/dist`   |
| `FILE_SERVER_CFG` |         | Additional config in [`file_server`-block](https://caddyserver.com/docs/caddyfile/directives/file_server) |
| `SERVER_CFG`      |         | Additional config in [server block](https://caddyserver.com/docs/caddyfile/directives) |
| `INTERVAL`        | 3600    | How many seconds in between git pulls    |
