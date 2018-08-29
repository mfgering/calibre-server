#
# Dockerfile for calibre-server
#

FROM frolvlad/alpine-glibc
LABEL maintainer="Mike Gering"
LABEL description="Run a calibre-server within an alpine container."

ENV CALIBRE_URL https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py
ENV CALIBRE_LIBRARY /books

RUN apk --update add bash xdg-utils wget python dumb-init libstdc++ mesa-gl fontconfig \
    && mkdir /books \
    && export PYTHONHTTPSVERIFY=0 \
    && wget -O- ${CALIBRE_URL} | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" \
    && echo "Got calibre"
RUN /opt/calibre/calibredb add -e --with-library=/books
COPY files/entrypoint.sh /entrypoint.sh
COPY files/add_user.py /add_user.py

EXPOSE 8080
VOLUME        ["/books"]
VOLUME        ["/root/.config/calibre"]

ENTRYPOINT ["dumb-init", "/entrypoint.sh"]
CMD ["calibre-server"]
