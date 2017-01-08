# How to NOT to Dockerize an app

We are super exited about docker and we give a flying fuck about reading the complete documentation so lets start writing our Dockerfile which is going to have PostgreSQL.

We start using ubuntu because that's what we are going to use in production, great.
```
FROM ubuntu:yakkety
```

Install base programs, create an user, regular stuff...

```
RUN apt-get update && apt-get install -y wget
#&& rm -rf /var/lib/apt/lists/*

ENV LOCAL_USER_ID=1000

RUN wget http://nodejs.org/dist/v6.6.0/node-v6.6.0-linux-x64.tar.gz
RUN tar -C /usr/local --strip-components 1 -xzf node-v6.6.0-linux-x64.tar.gz
RUN rm node-v6.6.0-linux-x64.tar.gz
RUN apt-get install -y postgresql
RUN apt-get install -y postgresql-client
RUN apt-get install -y git
RUN apt-get install -y make
RUN apt-get install -y python
RUN apt-get update && apt-get install -y g++

# Tools for debug
RUN apt-get install -y iputils-ping
RUN apt-get install -y curl

#Give ability to install packages from npm as globals <- this is wrong like so much wrong, but right now, I don have time for security XD
RUN apt-get install sudo

RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers

RUN groupadd -r rubylens -g 1000 && \
useradd -u 1000 -r -g rubylens -G sudo -d /home/rubylens -ms /bin/bash -c "Rubylens default user" rubylens && echo "rubylens:rubylens" | chpasswd
```

Now comes the trickie part, we want to pull the repo from bitbucket but it is private, how do we give our container de ssh keys to pull from it?

Easy, we create an ssh key using `ssh-keygen` in our folder and add the public key to bitbucket, when our container start the building process it will copy the private key to it and with that is going to be able to pull our repo. Smart right?

```
# Copy local key into container to make git clone
ADD rubylens /home/rubylens/.ssh/
RUN mv /home/rubylens/.ssh/rubylens /home/rubylens/.ssh/id_rsa
RUN ssh-keyscan -t rsa bitbucket.org >> /home/rubylens/.ssh/known_hosts
VOLUME /home/rubylens/shared
RUN chown -R rubylens:rubylens /home/rubylens

#Expose ports to outside world
EXPOSE 80

# RUN from here as rubylens <--- !important
USER rubylens
WORKDIR /home/rubylens/
RUN git clone git@bitbucket.org:psypersky/ruby-lens.git
WORKDIR /home/rubylens/ruby-lens/
```

We set up the database and construct the base schema and set the test data... regular DB stuff.
```
# DB installation steps
USER postgres
ENV PGPASSWORD="changethis"
RUN service postgresql start \
	&& createuser --superuser --createrole --no-password --inherit --login rubylens \
 	&& createdb -O rubylens -Eutf8 ruby-lens \
	&& psql -U postgres -d postgres -c "alter user rubylens with password 'changethis';" \
	&& psql -U rubylens -h localhost ruby-lens -f server/database/schema.sql \
	&& psql -U rubylens -h localhost ruby-lens -f server/database/games.sql

```

Install the npm modules and expose the port, nothing new.

```
# npm stuff
USER rubylens
RUN sudo npm install -g gulp
RUN npm install --no-optional
EXPOSE 3000
```

Now... how the fuck do i open the code that is inside the container in my text editor of preference on my host machine?

Well there is something called Volumes (shared filesystems), this thing mounts host directories into the docker container, this means that any data in the host in that folder will be shared on the container and any data in the container folder if any will be erased.

But wait... I wan't to share the data inside the docker container with the host, this is the other way around!
Well, yes... We tried to shared data from the container to the host and the simple answer is "you can't", if you want to dig more on this here is place to start: https://github.com/docker/docker/issues/26872

We tried to use them here and we failed!
```
#This stuff tries to expose the code to the host, but it doesn't work :(

#RUN mv /home/rubylens/ruby-lens /home/rubylens/shared/

# For Windows users please comment above line and uncomment the line underneath (make sure you have this directory)
#VOLUME C:\rubylens\repo /home/rubylens/ruby-lens
```

So our current work around is to run the docker image mounting a folder, once the docker image is running we move or copy the app's code to the shared folder and voilà we have a shared folder with the apps code :)

Run the container mounting a folder in it
`docker run -v /home/someUser/Projects/thisTut/shared:/home/rubylens/shared -it -e LOCAL_USER_ID=`id -u $USER` b13243b2edd5 /bin/bash`

Move the app's code to the shared folder
`mv /home/rubylens/ruby-lens /home/rubylens/shared/`

We can start our development from our favorite editor, Notepad!

Now the bad news... This hole Dockerfile is wrong, so much wrong xD... lets see why.

...
