#!/bin/bash
set -e

# Set UID/GID
PUID=${PUID:-911}
PGID=${PGID:-911}

# Set permissions
groupmod -o -g "$PGID" abc
usermod -o -u "$PUID" abc

# Create config directory for freerdp
if [ ! -d /config/.config ]; then
   mkdir -p /config/.config
   chown -R abc:abc /config
fi

gosu abc guacd -f -b 0.0.0.0
