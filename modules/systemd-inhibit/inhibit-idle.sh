#!/usr/bin/env bash
systemd-inhibit --what=idle bash -c "exec -a waycorner-inhibit-idle/sleep sleep infinity"
