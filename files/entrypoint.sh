#!/bin/bash
set -e

if [ "$1" = "bash" ]; then
	shift
	exec /bin/bash "$@"
fi
if [ "$1" = "manage-users" ]; then
	shift
	ARGS="$@ $CALIBRE_SERVER_ARGS"
	if [ ! -f "/root/.config/calibre/server-users.sqlite" ]; then
		/opt/calibre/calibre-server --manage-users
	fi
	echo "Launching server with $ARGS"
	/opt/calibre/calibre-server --daemonize --log=/dev/stdout $ARGS
	echo "Use ctl-p ctl-q to detach the terminal and keep running in the background."
	/bin/bash
fi
if [ "$1" = "calibre-server" ]; then
	shift
	ARGS="$@ $CALIBRE_SERVER_ARGS"
	echo "Launching server with $ARGS"
	exec /opt/calibre/calibre-server $ARGS
	echo "Use ctl-p ctl-q to detach the terminal and keep running in the background."
fi
echo "Do not uderstand $@"

