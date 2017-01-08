FROM ubuntu:yakkety

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

# DB installation steps
USER postgres
ENV PGPASSWORD="changethis"
RUN service postgresql start \
	&& createuser --superuser --createrole --no-password --inherit --login rubylens \
 	&& createdb -O rubylens -Eutf8 ruby-lens \
	&& psql -U postgres -d postgres -c "alter user rubylens with password 'changethis';" \
	&& psql -U rubylens -h localhost ruby-lens -f server/database/schema.sql \
	&& psql -U rubylens -h localhost ruby-lens -f server/database/games.sql

# npm stuff
USER rubylens
RUN sudo npm install -g gulp
RUN npm install --no-optional
EXPOSE 3000
#RUN sudo npm install webpack


#RUN mv /home/rubylens/ruby-lens /home/rubylens/shared/

# For Windows users please comment above line and uncomment the line underneath (make sure you have this directory)
#VOLUME C:\rubylens\repo /home/rubylens/ruby-lens
