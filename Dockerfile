FROM ubuntu:12.04
MAINTAINER Aaron Krieshok <akrieshok@gmail.com>

ADD ./drampal.sh /drampal.sh
RUN chmod 755 /drampal.sh
RUN /drampal.sh

ADD ./drupal.sh /drupal.sh
RUN chmod 755 /drupal.sh

RUN easy_install supervisor
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
RUN chmod 755 /start.sh && chmod 755 /etc/apache2/foreground.sh

RUN rm -f /drampal.sh

CMD ["/bin/bash", "/start.sh"]
