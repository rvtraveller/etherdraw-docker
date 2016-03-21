Etherdraw docker image
======================

[Etherdraw](https://github.com/JohnMcLear/draw.git) is a collaborative real-time
drawing / painting / sketching web based tool.

Docker images are hosted on [docker hub anybox/etherdraw]
(https://hub.docker.com/r/anybox/etherdraw)

Those images are based on `debian:jessie`, builds are schedules with
[nightli.es](https://nightli.es) and pushed to docker hub, this allow to
keep track system updates.

following tags are used:

* develop: to track change on [develop branch]
 (https://github.com/JohnMcLear/draw/tree/develop)
* stable: to track change on [master branch]
 (https://github.com/JohnMcLear/draw/tree/master)

Save your works into postgresql database
----------------------------------------

We assume you already have an other docker container called `pg_cluster` running
postgresql with an empty database called `etherdraw`.

Configure `~/etherdraw-settings.json` file:

```
{
  //IP and port which etherpad should bind at
  "ip" : "0.0.0.0",
  "port" : 9002,

  //database type. You can choose between dirty, postgres, sqlite and mysql
  //You shouldn't use "dirty" for for anything else than testing or development
  "dbType" : "postgres",
  //the database specific settings
  "dbSettings" : {
    "user"    : "postgres", 
    "host"    : "dbhost", 
    "password": "",
    "database": "etherdraw"
  },
  /* The default selected tool - 'pencil', 'brush', 'select' */
  "tool": "brush"
}
```

To get futhers informations about setting file, refer to [etherdraw]
(https://github.com/JohnMcLear/draw.git)

Then to run your container:
```
docker run -it --rm -p 127.0.0.1:9002:9002 --name etherdraw --link pg_cluster:dbhost -v ~/etherdraw-settings.json:/srv/etherdraw/draw/settings.json anybox/etherdraw:develop
```
