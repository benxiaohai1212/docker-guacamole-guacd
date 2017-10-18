#!/bin/bash
set -e

# Set UID/GID
PUID=${PUID:-911}
PGID=${PGID:-911}

# Set permissions
groupmod -o -g "$PGID" abc
usermod -o -u "$PUID" abc

# Link to the correct freerdp libs
ln -sf /usr/lib/freerdp/guacdr-client.so /usr/lib/x86_64-linux-gnu/freerdp/guacdr-client.so
ln -sf /usr/lib/freerdp/guacsnd-client.so /usr/lib/x86_64-linux-gnu/freerdp/guacsnd-client.so

# Create config directory for freerdp
if [ ! -d /config/.config ]; then
   mkdir -p /config/.config
   chown -R duser:users /config
fi

su-exec abc guacd -f -b 0.0.0.0
