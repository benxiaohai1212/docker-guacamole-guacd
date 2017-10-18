#!/bin/bash
set -e

# Link to the correct freerdp libs
ln -sf /usr/lib/freerdp/guacdr-client.so /usr/lib/x86_64-linux-gnu/freerdp/guacdr-client.so
ln -sf /usr/lib/freerdp/guacsnd-client.so /usr/lib/x86_64-linux-gnu/freerdp/guacsnd-client.so

# Create config directory for freerdp
if [ ! -d /config/.config ]; then
   mkdir -p /config/.config
   chown -R duser:users /config
fi

su-exec abc guacd -f -b 0.0.0.0
