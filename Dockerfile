FROM alpine:3.5

# RUN apt update -qq \
#    && apt upgrade -y -qq \
#    && apt install git curl unzip wget -y -q
RUN apk upgrade --no-cache && apk add --no-cache unzip curl bash tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
    
# Port for v2ray
EXPOSE 5211
EXPOSE 5212
EXPOSE 5213
EXPOSE 5214

# Setup V2Ray
RUN curl -L -s https://raw.githubusercontent.com/v2ray/v2ray-core/master/release/install-release.sh | bash
RUN rm -f /etc/v2ray/config.json
ADD config.json /etc/v2ray/config.json

ENTRYPOINT ["/usr/bin/v2ray/v2ray", "--config", "/etc/v2ray/config.json"]
