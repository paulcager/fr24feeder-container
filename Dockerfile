FROM debian:bullseye-slim

RUN dpkg --add-architecture armhf && \
    apt-get update && \
    apt-get install -y gnupg2 && \
    apt-key adv --recv-key --keyserver keyserver.ubuntu.com C969F07840C430F5 && \
    echo 'deb http://repo.feed.flightradar24.com flightradar24 raspberrypi-stable' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gnupg2 lsb-release dirmngr

# The install will fail because it tries to call systemctl - we can ignore this
# as long as /usr/bin/fr24feed has been installed.
RUN apt-get install -y fr24feed || [ -f /usr/bin/fr24feed ]

CMD ["/usr/bin/fr24feed"]
