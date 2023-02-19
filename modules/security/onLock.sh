#!/usr/bin/env bash

read -r uid < /proc/self/loginuid ||:
chown -h "$uid" "$(tty)";
exec sudo -u "#$uid" -- vlock -a
