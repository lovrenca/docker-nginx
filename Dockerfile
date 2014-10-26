#
#       .
#        ":"
#      ___:____     |"\/"|
#    ,'        `.    \  /
#    |  O        \___/  |
#  ~^~^~^~^~^~^~^~^~^~^~^~^~
#The nginx container

FROM ubuntu:latest
# Would use Kendu as the maintainer, but I need the account.
MAINTAINER Lovrenc Avsenek <a.lovrenc@gmail.com>

#Set loclaes. Oh yes this is meant to be edited before use!
RUN locale-gen %locale% && \
    echo LANG="%locale%" > /etc/default/locale

# Instaling package and clean up the mess
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
        nginx && \
    apt-get clean

EXPOSE 80
#Run!
CMD chmod 777 /opt/web/media; \
    chmod 755 /opt/web; \
    /usr/sbin/nginx -c /etc/nginx/nginx.conf