
# Docker Node.js Postgres Example Notes

__Example 1__   
Simple Example running Node.js in container copying the code at building time

__Example 2__   
Our first attempt to Dockerize a node.js app, very very wrong, this is a reference of how NOT to do it

__Example 3__   
Node.js app running in a container with the code shared between the host and the container, Postgresql running in another container and both containers running on the same Docker Network using docker-compose, success! :D


#### Tricky information

You can't easily mount a folder from the docker container to the host, that means that if you pull the code from within the container you won't be able to use a text editor in the host to edit that code.

Looks like it is preferable to leave the code in the host machine and mount a volume with the code in the container, this allow us to edit the code from the host machine and avoids having to build the machine for a simple code change that do not adds or remove any dependencies :D

More info: https://github.com/docker/docker/issues/26872

__References__   
https://docs.docker.com/   
https://goto.docker.com/rs/929-FJL-178/images/Docker-for-Virtualization-Admin-eBook.pdf   
https://scotch.io/tutorials/create-a-mean-app-with-angular-2-and-docker-compose   
http://blog.ionic.io/docker-hot-code-deploys/   
https://blog.newrelic.com/2016/06/20/docker-osx-mac/   

https://github.com/buildkite/nodejs-docker-example   
https://github.com/sameersbn/docker-postgresql   
https://github.com/nodejs/docker-node   
