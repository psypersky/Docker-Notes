
Build the image   
`docker build -t psypersky:koa-server .`

Run the image into a container with the code mounted
`docker run -t --name koa-server-container -p 3000:3000 -v /Users/psypersky/Documents/projects/Docker/node.js-example-3/app:/usr/src/app/code psypersky:koa-server`
