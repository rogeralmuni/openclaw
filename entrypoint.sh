#!/bin/sh
set -e

STARTUP_DELAY="${STARTUP_DELAY:-45}"

echo "OpenClaw startup delay: ${STARTUP_DELAY} seconds..."
sleep "${STARTUP_DELAY}"

echo "Starting OpenClaw Gateway..."
exec "$@"
