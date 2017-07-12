FROM debian:stretch

ARG GUACAMOLE_VERSION="0.9.12"
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME=/config

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

# Install build packages
RUN apt-get update -qq && \
    apt-get install -qy \ 
        gcc \
        make \
        libcairo2-dev \
        libpng-dev \
        libossp-uuid-dev \
        libvncserver-dev \
        libfreerdp-dev \
        libssl1.0-dev \
        libpango1.0-dev \
        libwebp-dev \
        libssh2-1-dev \
        libtelnet-dev \
        libpulse-dev \
        libvorbis-dev \
        wget && \

# Create user
    useradd -u 911 -U -d /config -s /bin/false duser && \
    usermod -G users duser && \
    groupmod -o -g 100 duser && \
    usermod -o -u 99 duser && \

# Install runtime packages
    apt-get install -qy \
        gir1.2-pango-1.0 \
        libcairo2 \
        libpango-1.0-0 \
        libwebp6 \
        libvncserver1 \
        libvncclient1 \
        libvorbis0a \
        libtelnet2 \
        libossp-uuid16 \
        libjpeg62-turbo \
        libssh2-1 \
        libfreerdp-client1.1 \
        libfreerdp-cache1.1 \
        libfreerdp-gdi1.1 \
        libfreerdp-rail1.1 \
        libfreerdp-plugins-standard \
        libxfreerdp-client1.1 \
        libpulse0 \
        xfonts-terminus && \

# Install guacd
    wget -O /tmp/guacamole-server.tar.gz "http://apache.org/dyn/closer.cgi?action=download&filename=incubator/guacamole/${GUACAMOLE_VERSION}-incubating/source/guacamole-server-${GUACAMOLE_VERSION}-incubating.tar
.gz" && \
    tar xzf /tmp/guacamole-server.tar.gz -C /tmp && \
    cd /tmp/guacamole-server-${GUACAMOLE_VERSION}-incubating && \
    ./configure --prefix=/usr --sbindir=/usr/bin && \
    make && \
    make install && \
    ldconfig && \

# Cleanup
    apt-get purge -qq \
        gcc \
        make \
        libcairo2-dev \
        libpng-dev \
        libossp-uuid-dev \
        libvncserver-dev \
        libfreerdp-dev \
        libssl-dev \
        libpango1.0-dev \
        libwebp-dev \
        libssh2-1-dev \
        libtelnet-dev \
        libpulse-dev \
        libvorbis-dev \
        wget && \
    apt-get -y autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

# Set file permissions
    chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
