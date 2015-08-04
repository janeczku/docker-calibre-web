# Calibre Web docker image

![screenshot](https://raw.githubusercontent.com/janeczku/docker-calibre-web/master/screenshot.png)

This Dockerfile provides the [janeczku/calibre-web](https://registry.hub.docker.com/u/janeczku/calibre-web/) image based on CentOS 7, Supervisord, Gunicorn and Nginx reverse proxy.

## About Calibre Web

[Calibre Web](https://github.com/janeczku/calibre-web/) is a Python web app allowing one to browse, download and read the books contained in a Calibre e-book collection.

GitHub project:

https://github.com/janeczku/calibre-web/

## Getting Started

The Calibre database can either be made available to the container by mounting a local folder to `/calibre` mount point or by mounting an existing volume from another container. The latter method comes in handy if one wants to sync the Calibre database from a NAS, Dropbox or similar share.

### Using a Calibre database located on the host

    docker run -d --name calibre-web -v /path/to/calibre_database:/calibre -p 8080:80 janeczku/calibre-web

### Using a Calibre database located in an existing volume
In this example we are first launching the [Docker Dropbox](https://registry.hub.docker.com/u/thomfab/docker-dropbox/) image to sync the Calibre database from a Dropbox account to a volume on the host. Subsequently we can then mount this volume to the Calibre Web container. This allows our database to be  continually up to date. It is recommended to setup a distinct Dropbox account for this purpose as the container will download all data from the linked account.

Launch the Docker dropbox container.

    docker run -d --name dropbox thomfab/docker-dropbox

Check the logs of the container to get URL to authenticate with your Dropbox account.

	docker logs dropbox

Copy and paste the URL in a browser and login to your Dropbox account to associate.

	docker logs dropbox

You should see something like this:
> "This computer is now linked to Dropbox. Welcome xxxx"

The dropbox files are stored in the `/dropbox/Dropbox` volume. When mounting this volume to the Calibre Web container, we can tell it about the location of the Calibre database by supplying the environmental variable `CALIBRE_PATH`. Supposing the Calibre database folder is named `calibre` and located in the root of the Dropbox account:

	docker run -d --name calibre-web --volumes-from dropbox --env CALIBRE_PATH=/dropbox/Dropbox/calibre -p 8080:80 janeczku/calibre-web

## ENV variables

**CALIBRE_PATH**  
Default: `CALIBRE_PATH=/calibre`  
Configure the path where the Calibre database is located. This is only needed when using an existing volume from another container.
