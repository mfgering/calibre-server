#!/bin/bash
set -e

if [ "$1" = "bash" ]; then
	shift
	exec /bin/bash "$@"
fi
if [ "$1" = "manage-users" ]; then
	exec /opt/calibre/calibre-server --manage-users
fi
if [ "$1" = "calibre-server" ]; then
	shift
	echo "Launching server with $@"
	exec /opt/calibre/calibre-server "$@"
fi
echo "Do not uderstand $@"

