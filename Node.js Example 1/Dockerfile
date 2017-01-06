# Using the image of Node.js version 7
# this is the file system of the stuff needed to run Node 7 and Node
FROM node:7

# Create our app folder
RUN mkdir /app

# Set the default dir for all subsequent commands
WORKDIR /app

# To being able to use node programs without specifying path
ENV PATH /app/node_modules/.bin:$PATH

# Install npm modules
ADD package.json /app
RUN npm install

# Copy the code into the docker container
ADD . /app

# This is the command executed when running the container
# if we send another command it will be replaced and not executed
CMD ["node", "index.js"]
