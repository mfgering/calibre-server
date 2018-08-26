#
# Dockerfile for calibre-server
#

FROM ubuntu
LABEL maintainer="Mike Gering"
LABEL description="Run a calibre-server within an ubuntu container."

ENV CALIBRE_URL https://download.calibre-ebook.com/linux-installer.sh
ENV CALIBRE_DEPS xdg-utils wget xz-utils python 

RUN set -xe \
    && apt-get update \
    && apt-get install -y $CALIBRE_DEPS \
    && mkdir /books \
    && wget -nv -O- $CALIBRE_URL | sh /dev/stdin \
    && calibredb add -e --with-library=/books \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/*
COPY files/calibre /root/.config/calibre
COPY files/entrypoint.sh /root/entrypoint.sh

EXPOSE 8080
VOLUME        ["/books"]

#NOTE: The --enable-auth option requires users and passwords be
# initialized in /root/.config/calibre/server-users.sqlite
# Use the calibre-server --manage-users option to set it up
ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["calibre-server", "--enable-auth", "/books"]

