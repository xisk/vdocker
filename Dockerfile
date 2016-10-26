FROM debian:jessie


RUN echo "Asia/Shanghai" > /etc/timezone
RUN apt update -qq \
    && apt upgrade -y -qq \
    && apt install git curl unzip wget -y -q

# Port for v2ray
EXPOSE 5113
EXPOSE 5114

# Setup V2Ray
RUN curl -L -s https://raw.githubusercontent.com/v2ray/v2ray-core/master/release/install-release.sh | bash
RUN rm -f /etc/v2ray/config.json
ADD config.json /etc/v2ray/config.json

ENTRYPOINT ["/usr/bin/v2ray/v2ray", "--config", "/etc/v2ray/config.json"]
