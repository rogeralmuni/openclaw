#!/bin/sh
set -e

STARTUP_DELAY="${STARTUP_DELAY:-45}"

echo "OpenClaw startup delay: ${STARTUP_DELAY} seconds..."
sleep "${STARTUP_DELAY}"

disable_control_ui=false
prev=""
for arg in "$@"; do
  if [ "$prev" = "--bind" ] && [ "$arg" = "lan" ]; then
    disable_control_ui=true
  fi
  prev="$arg"
done

if [ "$disable_control_ui" = true ]; then
  echo "Disabling Control UI for bind=lan to avoid allowedOrigins requirement..."
  if node openclaw.mjs config set gateway.controlUi.enabled false >/dev/null 2>&1; then
    echo "Control UI disabled."
  else
    echo "Warning: failed to disable Control UI; gateway startup may still fail."
  fi
fi

echo "Starting OpenClaw Gateway..."
exec "$@"
