#
# Dockerfile for calibre-server
#

FROM ubuntu
LABEL maintainer="Mike Gering"
LABEL description="Run a calibre-server within an ubuntu container."

ENV CALIBRE_URL https://download.calibre-ebook.com/linux-installer.sh
ENV CALIBRE_DEPS xdg-utils wget xz-utils python dumb-init
ENV CALIBRE_SERVER_ARGS --enable-auth /books

RUN set -xe \
    && apt-get update \
    && apt-get install -y $CALIBRE_DEPS \
    && mkdir /books \
    && wget -nv -O- $CALIBRE_URL | sh /dev/stdin \
    && calibredb add -e --with-library=/books \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/*
COPY files/entrypoint.sh /entrypoint.sh

EXPOSE 8080
VOLUME        ["/books"]

ENTRYPOINT ["dumb-init", "/entrypoint.sh"]
CMD ["calibre-server"]
