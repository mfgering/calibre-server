Introduction
============

The goal for this image is to run a calbre server that can interact with my favorite android ebook reader, *MoonReader+*, and allow uploading, deleting and modifying books in the library.

I tried using the more attractive *calibre-web* program. Unfortunately, it does not play well with *MoonReader+*, so I'm forced to use the *calibre-server* program.

This docker image runs a calibre server in an Ubuntu OS.

Only authenticated users can modify a calibre-server library. The docs say that the *--enable-local-write* flag is to "Allow un-authenticated local connections to make changes. Normally, if you do not turn on authentication, the server operates in read-only mode, so as to not allow anonymous users to make changes to your calibre libraries." I couldn't get it to work, however.

To allow the *calibre-server* to make changes, the server needs to run with *--enable-auth* and to have users configured in the user database (see below).

Configuration
=============

Configure the server with CLI flags and *calibre-server --manage-users*

The image is built with configuration files from *files/calibre*. In particular, the *files/server-users.sqlite* file contains the user information for authentication, etc.