
FROM ubuntu:16.04

MAINTAINER <bekbaganbetov.abay@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y octave default-jre git vim && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/www && cd /var/www && git clone https://github.com/precisesimulation/matlab-octave-web-server-interface.git .

EXPOSE 4000

CMD ["octave"]
