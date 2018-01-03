# Image
[![](https://images.microbadger.com/badges/image/tunip/guacamole-guacd.svg)](https://microbadger.com/images/tunip/guacamole-guacd "Get your own image badge on microbadger.com")

# About
![Guacamole-guacd](https://github.com/tunip/docker-guacamole-guacd/raw/master/guacamole-guacd.png)

Guacamole server (remote desktop proxy for RDP, VNC, SSH and telnet) based on Debian.

# Usage
```
docker run -d --name="guacamole-guacd" \
    -p 4822:4822 \
    tunip/guacamole-guacd
```
