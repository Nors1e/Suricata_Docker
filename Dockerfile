FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=non-interactive

RUN apt-get update

RUN apt-get install -y wget build-essential autoconf automake libtool

RUN apt-get install -y \
    libpcre3 libpcre3-dbg libpcre3-dev libpcre2-dev \
    libpcap-dev libnet1-dev \
    libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libcap-ng-dev libcap-ng0 \
    make libmagic-dev libjansson-dev libnss3-dev \
    libgeoip-dev liblua5.1-dev libhiredis-dev libevent-dev \
    python-yaml rustc cargo

RUN wget https://www.openinfosecfoundation.org/download/suricata-7.0.1.tar.gz \
    && tar -xvzf suricata-7.0.1.tar.gz \
    && cd suricata-7.0.1 \
    && ./configure --enable-nfqueue --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
    && make \
    && make install-full

# Specified Port
EXPOSE 80

# Initialize Command
CMD ["suricata", "-c", "/etc/suricata/suricata.yaml", "-i", "eth0"]
