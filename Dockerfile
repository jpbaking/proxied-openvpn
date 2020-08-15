FROM ubuntu:20.04

RUN set -xv; \
    echo -e 'nameserver 8.8.8.8\nnameserver 8.8.4.4\n' > /etc/resolv.conf; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get upgrade -y --allow-downgrades --allow-remove-essential --allow-change-held-packages; \
    apt-get install -y \
      openssh-server openssh-client \
      openvpn squid apache2 \
      net-tools iputils-ping dnsutils iproute2 traceroute \
      wget curl vim \
      nodejs npm; \
    apt-get remove --purge -y; \
    apt-get autoremove -y; \
    apt-get clean; \
    apt-get autoclean; \
    rm -rf /var/lib/apt/lists/*; \
    npm install -g pm2;

WORKDIR /root/

COPY ./scripts ./scripts
COPY ./ovpn ./ovpn
COPY ./tools ./tools
COPY ./config/squid.conf /etc/squid/squid.conf
COPY ./config/pm2.yaml ./pm2.yaml

CMD /usr/local/bin/pm2-runtime /root/pm2.yaml
