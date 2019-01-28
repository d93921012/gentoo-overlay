#!/bin/bash

# Check if certificates exist.  If not, we need to generate them, ala sshd.
if [ ! -e /etc/vmware/ssl/rui.key -o ! -e /etc/vmware/ssl/rui.crt ]; then
        chmod 0600 /etc/vmware/ssl
        openssl req -x509 -days 365 -newkey rsa:2048 -keyout /etc/vmware/ssl/rui.key -out /etc/vmware/ssl/rui.crt -config /etc/vmware/ssl/hostd.ssl.config
        chmod 0600 /etc/vmware/ssl/rui.key /etc/vmware/ssl/rui.crt
fi
