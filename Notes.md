
docker stop [OPTIONS] CONTAINER [CONTAINER...]

__Remove Docker Image
docker rmi [OPTIONS] IMAGE [IMAGE...]


__List stopped containers__
docker ps -a

Remove one or more containers
docker rm [OPTIONS] CONTAINER [CONTAINER...]

Remove one or more images
docker rmi [OPTIONS] IMAGE [IMAGE...]

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)


docker stats


Continuos delivery and stuff
http://dchq.co/


Dockerfiles are pretty neat things. They allow us to do fun stuff, like take someone’s else’s image as a base and build more stuff on top of it. This is the basis for nearly all of the images I use – find someone else who did the hard work, like installing Nginx, or Apache, or a database like Postgres or MySQL, and then add the pieces I need to get the results I want.
