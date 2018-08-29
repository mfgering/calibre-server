Introduction
============

The goal for this image is to run a calbre server that can interact with my favorite android ebook reader, *MoonReader+*, and allow uploading, deleting and modifying books in the library.

I tried using *calibre-web* program. Unfortunately, it does not play well with *MoonReader+*, so I'm forced to use the *calibre-server* program.

This docker image runs a calibre server in an Alpine OS.

You will need one or more users and use authentication for modifying the library via the web interface. There are two ways to accomplish this, 
as you will see in the following section.

Configuration
=============

This image is created with a default empty library at */books*. You can use a persistent volume for */books* to keep the library in a different place.

The */root/.config/calibre* volume is where Calibre stores its configuration files,
including an optional users database, *server-users.sqlite*. 

If you want Calibre to use authentication, you should define and manage one or
more users. You can add a user and password two ways:

1. Define environment variables *CALIBRE_USER* and *CALIBRE_PASS* when
running this image, and/or

2. Run the related image,  *mgering/calibre-users* with
the same volume for */root/.config/calibre*. Then when you run this container, the
startup script will notice that the user database exists, and it will supply 
the *--enable-auth* option to the *calibre-server*.

Operation
=========

Basic way to run this image:

```
docker run -d -v calibre-config:/root/.config/calibre -v calibre-library:/books -p 9080:8080 mgering/calibre-server
```

Details for the above command:
* The *-d* flag makes the container run in the background.
* The *calibre-config* volume is used to hold the configuration, including the user database.
* The *calibre-library* volume is used to hold the books
* The server web interface is exposed on port 8080 and mapped to the host's port 9080.

If you want to use authentication, you can add a user to the server's database
by passing in two environment variables, CALIBRE_USER* and *CALIBRE_PASS*:

```
CALIBRE_USER=user CALIBRE_PASS=password docker run -d -e CALIBRE_USER -e CALIBRE_PASS -v calibre-config:/root/.config/calibre -v calibre-library:/books -p 9080:8080 mgering/calibre-server
```

Notice that in the above example, the environment variables are given values
before the *docker run* command and they are only referred to by name in the 
command itself. This prevents the values from showing up in the docker metadata
at runtime, e.g. with the *docker ps* command.

Also, if the given user already exists in the database, the password is updated.
