#!/bin/bash
set -e

export DISPLAY=${DISPLAY:-:99}
export PORT=${PORT:-10000}

Xvfb $DISPLAY -screen 0 1280x800x16 &
fluxbox &
chromium --no-sandbox --disable-setuid-sandbox --disable-dev-shm-usage --disable-gpu &
x11vnc -display $DISPLAY -nopw -forever -shared -rfbport 5900 &

exec websockify --web=/usr/share/novnc 0.0.0.0:$PORT localhost:5900
