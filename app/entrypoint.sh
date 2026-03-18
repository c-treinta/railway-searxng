#!/bin/sh
set -e
: "${SEARXNG_SECRET_KEY:?SEARXNG_SECRET_KEY must be set}"
sed -i "s|BIND_PORT_PLACEHOLDER|${PORT:-8080}|g" /etc/searxng/settings.yml
sed -i "s|SEARXNG_SECRET_KEY_PLACEHOLDER|${SEARXNG_SECRET_KEY}|g" /etc/searxng/settings.yml
if [ -n "${SEARXNG_ADMIN_PASSWORD:-}" ]; then
  sed -i "s|# ADMIN_PASSWORD_PLACEHOLDER|password: \"${SEARXNG_ADMIN_PASSWORD}\"|g" /etc/searxng/settings.yml
fi
exec /usr/local/searxng/entrypoint.sh "$@"
