FROM tianon/apache2

MAINTAINER chris@cbeer.info
ENV EPRINTS_HOME /usr/share/eprints3

RUN echo "deb http://deb.eprints.org/ unstable/" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.eprints.org/ source/" >> /etc/apt/sources.list
RUN sed -i "s/precise/precise universe/" /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y dpkg-dev sudo
RUN apt-get install --force-yes -y eprints
RUN apt-get install -y expect

ADD eprints3.httpd.conf /etc/apache2/sites-available/eprints3.conf
RUN a2ensite eprints3

ADD install-eprints.expect /tmp/install-eprints.expect 
ADD initialize-eprints.expect /tmp/initialize-eprints.expect
ADD initialize-eprints.sh /tmp/initialize-eprints.sh

RUN sudo -u eprints expect -f /tmp/install-eprints.expect

CMD /tmp/initialize-eprints.sh && apache2 -DFOREGROUND
