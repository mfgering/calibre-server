#!/bin/bash
#set -x
set -e
echo "library: $CALIBRE_LIBRARY"

if [ "$1" = "bash" ]; then
	shift
	exec /bin/bash "$@"
fi
if [ "$1" = "calibre-server" ]; then
	if [ ! "$CALIBRE_USER" = "" ]; then
	/opt/calibre/calibre-debug add_user.py "$CALIBRE_USER" "$CALIBRE_PASS"
	AUTH_OPT=""
	if [ -f "/root/.config/calibre/server-users.sqlite" ]; then
		AUTH_OPT="--enable-auth"
	fi
	shift
	exec /opt/calibre/calibre-server $AUTH_OPT $@ $CALIBRE_LIBRARY
fi
echo "Do not uderstand $@"

