#Required params
FROM debian:wheezy
MAINTAINER Lovrenc Avsenek <a.lovrenc@gmail.com>

ENV     DEBIAN_FRONTEND noninteractive

# Instaling package and clean up the mess
RUN apt-get update && \
    apt-get -y install \
        nginx && \
    apt-get clean

#Add nginx config
RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/nginx.conf
ADD sites-enabled/ /etc/nginx/sites-enabled/

#Open ports
EXPOSE 80
EXPOSE 443

#Run!
CMD /usr/sbin/nginx -c /etc/nginx/nginx.conf