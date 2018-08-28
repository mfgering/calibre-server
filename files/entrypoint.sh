#!/bin/bash
#set -x
set -e
echo "library: $CALIBRE_LIBRARY"

if [ "$1" = "bash" ]; then
	shift
	exec /bin/bash "$@"
fi
if [ "$1" = "manage-users" ]; then
	exec /opt/calibre/calibre-server --manage-users
fi
if [ "$1" = "calibre-server" ]; then
	AUTH_OPT=""
	if [ -f "/root/.config/calibre/server-users.sqlite" ]; then
		AUTH_OPT="--enable-auth"
	fi
	shift
	exec /opt/calibre/calibre-server $AUTH_OPT $@ $CALIBRE_LIBRARY
fi
echo "Do not uderstand $@"

