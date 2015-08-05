# Calibre Web docker image

![screenshot](https://raw.githubusercontent.com/janeczku/docker-calibre-web/master/screenshot.png)

This Dockerfile provides the [janeczku/calibre-web](https://registry.hub.docker.com/u/janeczku/calibre-web/) image based on CentOS 7, Supervisord, Gunicorn and Nginx reverse proxy.

## About Calibre Web

[Calibre Web](https://github.com/janeczku/calibre-web/) is a Python web app allowing one to browse, download and read the books contained in a Calibre e-book collection.

GitHub project:

https://github.com/janeczku/calibre-web/

## Getting Started

The Calibre database can either be made available to the container by mounting a local folder to `/calibre` mount point or by mounting an existing volume from another container. The latter method comes in handy if one wants to sync the Calibre database from a NAS, Dropbox or similar share.

### Using a Calibre database folder located on the host

    docker run -d --name calibre-web \
    -v /path/to/calibre/database/folder:/calibre \
    -p 8080:80 janeczku/calibre-web

### Using a Calibre database folder located in an existing volume
In this example we are first launching the [Docker Dropbox](https://registry.hub.docker.com/u/janeczku/dropbox/) image to sync the Calibre database from a Dropbox account to a volume on the host. Subsequently we can then mount this volume in the Calibre Web container, so that the ebook database is always up-to-date. It is recommended to use a distinct Dropbox account for this purpose as the container will download all data from the linked account by default (Alternatively you can set-up selective sync - see "manage exclusions" below)

Launch the Docker Dropbox container.

    docker run -d --restart=always --name=dropbox \
    -e DBOX_UID=80 \
    -e DBOX_GID=80 \
    janeczku/dropbox

Check the logs of the container to get URL to authenticate with your Dropbox account.

	docker logs dropbox

Copy and paste the URL in a browser and login to your Dropbox account to associate.

	docker logs dropbox

You should see something like this:

> "This computer is now linked to Dropbox. Welcome xxxx"

To manage exclusions and check sync status do:

	docker exec -t -i dropbox dropbox help

The docker dropbox image stores the synced files in the `/dbox/Dropbox` volume. When mounting the exposed volumes to the Calibre Web container, we have to tell it about the location of the Calibre database by supplying it in the `CALIBRE_PATH` ENV variable. Supposing the Calibre database folder is named `Calibre` and located in the root of the Dropbox account we do the following:

	docker run -d --name calibre-web \
	--volumes-from dropbox \
	--env CALIBRE_PATH=/dbox/Dropbox/Calibre \
	-p 8080:80 janeczku/calibre-web

## Using the app

Open the app in your browser. Login as user `admin` with the password `admin123`. Don't forget to change the default password.

## ENV variables

**CALIBRE_PATH**  
Default: `CALIBRE_PATH=/calibre`  
Configure the path where the Calibre database is located. This is only needed when using an existing volume from another container.
