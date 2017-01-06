# Simple Node.js application dockerized

We start by creating a simple Node.js application using koa.js that returns "hello world" on port 3000.

index.js => our node.js app  
package.json => our npm dependencies and stuff  
readme.md => you are reading it  

Next we create our Dockerfile  
`touch Dockerfile`  
(Read the docker file to see what it does)

__Build__

Now that we have our Docker File we create an image which contains the file system of our app ready to run, but it doesn't run with this command.   

`docker build -t node-example:v1 .`

__Run__

We run our image, and create a container (an image running), also bind the port of the container to the port of our host machine.

`docker run -t -p 3000:3000 -i node-example:v1`

We set a name for it so if we create another one with the same name docker will complain, this will avoid creating lots of images that stay on disk and occupy space, if we don't set the name docker daemon will assign a random string name.

__Test__

`curl localhost:3000`   

Awesome, we have a Node.js app running on a docker container on Linux and it starts in fractions of a second!
