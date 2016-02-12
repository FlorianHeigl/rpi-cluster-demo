#!/bin/bash
#

HAPROXY="/etc/haproxy"
OVERRIDE="/haproxy-override"
PIDFILE="/var/run/haproxy.pid"

CONFIG="haproxy.cfg"
ERRORS="errors"

cd "$HAPROXY"

# Symlink errors directory
if [[ -d "$OVERRIDE/$ERRORS" ]]; then
  mkdir -p "$OVERRIDE/$ERRORS"
  rm -fr "$ERRORS"
  ln -s "$OVERRIDE/$ERRORS" "$ERRORS"
fi

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi

quitall () {
  kill -TERM $(cat $PIDFILE)
} 
  
if [ $# -eq 0 ]; then
  echo "trap"
  trap 'quitall ' TERM INT  
  haproxy -D -f /etc/haproxy/haproxy.cfg -p "$PIDFILE"
  while true; do
    sleep 3600
  done
else
  echo "reloading haproxy"
  cat $PIDFILE
  haproxy -D -f /etc/haproxy/haproxy.cfg -p "$PIDFILE" -sf $(cat "$PIDFILE") &
fi

