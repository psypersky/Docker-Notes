# Create image based on the official Node 7 image from dockerhub
FROM node:7

RUN apt-get update && apt-get install -y \
  wget \
  postgresql-client

# Add psql to PATH
RUN echo 'export PATH=/usr/lib/postgresql/9.4/bin:$PATH:/usr/sbin' >> ~/.bashrc

# Create a directory where our app will be placed
RUN mkdir -p /usr/src/app

# Change directory so that our commands run inside this new directory
WORKDIR /usr/src/app

# Copy dependency definitions
COPY package.json /usr/src/app

# Install dependecies
RUN npm install

# Expose the port the app runs in
EXPOSE 3000

# Serve the app
CMD ["node", "code/index.js"]
