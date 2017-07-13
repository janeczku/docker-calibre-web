# Calibre Web docker image

**This image has been deprecated. Please see [here](https://github.com/janeczku/calibre-web#docker-image) for links to alternative Docker images for Calibre Web.**

![screenshot](https://raw.githubusercontent.com/janeczku/docker-calibre-web/master/screenshot.png)

This Dockerfile provides the [janeczku/calibre-web](https://registry.hub.docker.com/u/janeczku/calibre-web/) image based on CentOS 7, Supervisord, Gunicorn and Nginx reverse proxy.

## About Calibre Web

[Calibre Web](https://github.com/janeczku/calibre-web/) is a Python web app allowing one to browse, download and read the books contained in a Calibre e-book collection.

GitHub project:

https://github.com/janeczku/calibre-web/

## Getting Started

You can make your Calibre database available to the container either by mounting the host folder to `/calibre` or by mounting an existing volume from another container. The latter method comes in handy if you want to sync the Calibre database from a NAS, Dropbox or similar share.

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

	"This computer is now linked to Dropbox. Welcome xxxx"

To manage exclusions and check sync status do:

	docker exec -t -i dropbox dropbox help

Then start the calibre-web container mounting the volumes from the dropbox container:

	docker run -d --name calibre-web \
	--volumes-from dropbox \
	-p 8080:80 janeczku/calibre-web

The docker dropbox container stores synced files in the `/dbox/Dropbox` volume. Given that the Calibre database folder is named `Calibre` and located in the root of the Dropbox account you would then have to configure the Calibre database location as `/dbox/Dropbox/Calibre` (see below).

## Using the app - Quick start

1. Point your browser to `http://hostname:8080` (or whatever host port you mapped the container to)
2. Set `Location of Calibre database` to the path of the folder where you mounted your Calibre folder in the container (e.g. /calibre)
3. Hit "submit" then "login".  

**Default admin login:**    
*Username:* admin   
*Password:* admin123
       
To access the OPDS catalog feed, point your Ebook Reader to `http://hostname:8080/opds`.

## ENV variables

**SSL_CERT_NAME**  
Default: ` `    

To use a custom SSL certificate copy or mount the crt file to /etc/nginx/ssl and set this environment variable to the cert's filename, e.g. "example.com.crt". Don't forget modify your `docker run` command to map port 443 from the container to the host.

**SSL_KEY_NAME**  
Default: ` `    

To use a custom SSL certificate copy or mount the private key file to /etc/nginx/ssl and set this environment variable to the key's filename, e.g. "example.com.key".

**CALIBRE_DBPATH**  
Default: ``    

Custom folder for the application database (note: this is not the Calibre ebook database). You may use this persist application data in a volume.

## Running behind additional reverse proxy

Configure your proxy to pass it's public hostname in the `X-Forwarded-Host` header.
