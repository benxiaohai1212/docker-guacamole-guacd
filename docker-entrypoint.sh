#!/bin/bash
set -e

# Link to the correct freerdp libs
ln -sf /usr/lib/freerdp/guacdr-client.so /usr/lib/x86_64-linux-gnu/freerdp/guacdr-client.so
ln -sf /usr/lib/freerdp/guacsnd-client.so /usr/lib/x86_64-linux-gnu/freerdp/guacsnd-client.so

# Create directory
if [ ! -d /config/.config ]; then
   mkdir -p /config/.config
   chown -R duser:users /config
fi

exec su -s /bin/sh -c 'guacd -f -b 0.0.0.0' duser
