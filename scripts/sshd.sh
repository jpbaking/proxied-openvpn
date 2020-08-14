#!/bin/bash

mkdir -p /var/run/sshd
/usr/sbin/sshd -D 2>&1