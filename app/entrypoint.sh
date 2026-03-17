#!/bin/sh
set -e
: "${SEARXNG_SECRET_KEY:?SEARXNG_SECRET_KEY must be set}"
sed -i "s|BIND_PORT_PLACEHOLDER|${PORT:-8080}|g" /etc/searxng/settings.yml
sed -i "s|SEARXNG_SECRET_KEY_PLACEHOLDER|${SEARXNG_SECRET_KEY}|g" /etc/searxng/settings.yml
exec /usr/local/searxng/dockerfiles/docker-entrypoint.sh "$@"
