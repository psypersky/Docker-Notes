Here we use Docker compose to create a Koa.js Server and a Postgresql Server, both on the same Docker Network.

We have two images

The koa-server boots a server on port 3000, bind the port to the host and mounts a volume from the host's /app folder and insert it in container's /usr/src/app this way if we change the code it will be change on the container's too, we could set up a listener to re-boot the server on code change like nodemon or pm2 :D

The db-server gets the postgres oficial image and include a small script to create an user and database that takes from the env vars, which are declared in the `docker-compose.yml` file, also runs an `schema.sql` file that creates a table under the recently created user, and edit's the pg_conf to allow remote connections, for more info check the database's README.

Booting up the servers   
`docker-compose up`   

And that's fucking it!

Testing that the koa-server has network access to the db-server   
`docker exec -it koa-server bash`   
`psql -h db-server -U admin db`
