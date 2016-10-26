FROM ubuntu
#MAINTAINER "xisk" <xisk@xisk.com>

# Basic environment setting
RUN echo "Asia/Shanghai" > /etc/timezone
RUN apt update -qq \
    && apt upgrade -y -qq \
    && apt install git curl unzip wget -y -q

# Port for v2ray
EXPOSE 10010

# Setup V2Ray
RUN curl -L -s https://raw.githubusercontent.com/v2ray/v2ray-core/master/release/install-release.sh | bash
RUN mv /etc/v2ray/config.json /etc/v2ray/config.json.bak
ADD config.json /etc/v2ray/config.json

# Have fun
ENTRYPOINT ["/usr/bin/v2ray/v2ray", "--config", "/etc/v2ray/config.json"]
