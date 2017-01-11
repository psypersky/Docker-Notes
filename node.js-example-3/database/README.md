The Dockerfile creates a database image with an user and initialize db tables

Accepts remote connections from Docker IPs - all 172.17.0.1/16 IP addresses.

Sets up database according to environment variables:
DB_NAME database
DB_USER admin
DB_PASS password

### How to use:

Build the image   
`docker build -t psypersky/postgres .`   

Create the container with our db, user and pass (awesome-db is the name of the container)   
`docker run --name awesome-db -t -e DB_NAME=db -e DB_USER=admin -e DB_PASS=password psypersky/postgres`   

Enter to db in the container to test all is working   
`docker exec -it awesome-db psql --dbname db --username admin`   

Or from docker-compose setting the env vars in the configuration


Inspiration from:   
https://osxdominion.wordpress.com/2015/01/25/customizing-postgres-in-docker/
