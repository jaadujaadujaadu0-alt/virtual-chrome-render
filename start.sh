#!/bin/bash
set -e

export DISPLAY=:99
export PORT=${PORT:-10000}

rm -f /tmp/.X99-lock

Xvfb :99 -screen 0 1366x768x24 &
sleep 2

fluxbox &
sleep 2

x11vnc \
  -display :99 \
  -forever \
  -shared \
  -nopw \
  -rfbport 5900 &
sleep 2

chromium \
  --no-sandbox \
  --disable-setuid-sandbox \
  --disable-dev-shm-usage \
  --disable-gpu \
  --disable-software-rasterizer \
  --disable-features=VizDisplayCompositor \
  --user-data-dir=/tmp/chrome \
  https://google.com &

exec websockify \
  --web=/usr/share/novnc \
  0.0.0.0:$PORT \
  localhost:5900
