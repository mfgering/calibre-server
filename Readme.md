Introduction
============

The goal for this image is to run a calbre server that can interact with my favorite android ebook reader, *MoonReader+*, and allow uploading, deleting and modifying books in the library.

I tried using *calibre-web* program. Unfortunately, it does not play well with *MoonReader+*, so I'm forced to use the *calibre-server* program.

This docker image runs a calibre server in an Ubuntu OS.

A related docker image is used to manage the user database: *mgering/calibre-users*.
You will need one or more users and use authentication for modifying the library via the web interface.

Configuration
=============

This image is created with a default empty library at */books*. You can use a persistent volume for */books* to keep the library in a different place.

The */root/.config/calibre* volume is where Calibre stores its configuration files,
including an optional users database, *server-users.sqlite*. 

If you want Calibre to use authentication, you should define and manage one or
more users. The easiest way is to run another image, *mgering/calibre-users* with
the same volume for */root/.config/calibre*. Then when you run this container, the
startup script will notice that the user database exists, and it will supply 
the *--enable-auth* option to the *calibre-server*.

Operation
=========

Optionally, first prepare a user database with *mgering/calibre-users* if you want to use authentication.

Then run this image:

```
docker run -d -v calibre-config:/root/.config/calibre -v calibre-library:/books -p 9080:8080 mgering/calibre-server
```

Details for the above command:
* The *-d* flag makes the container run in the background.
* The *calibre-config* volume is used to hold the configuration, including the user database.
* The *calibre-library* volume is used to hold the books
* The server web interface is exposed on port 8080 and mapped to the host's port 9080.

