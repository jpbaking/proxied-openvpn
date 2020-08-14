#!/bin/bash

if [ ! -d /dev/net ]; then
  mkdir -p /dev/net
  mknod /dev/net/tun c 10 200
  chmod 600 /dev/net/tun
fi

cd /root/ovpn
if [ ! -f connect.sh ]; then
  echo '[ERROR] /root/ovpn/connect.sh NOT found'
  exit 1
fi
/bin/bash connect.sh
