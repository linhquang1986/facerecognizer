#
# Ubuntu Node.js Dockerfile
#
# https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
# https://docs.docker.com/examples/nodejs_web_app/
#

# Pull base image.
FROM ubuntu:16.04

# Install Node.js
RUN apt-get update
RUN apt-get install --yes curl
RUN apt-get install --yes build-essential
RUN curl --silent --location https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install --yes nodejs

# Bundle app source
# Trouble with COPY http://stackoverflow.com/a/30405787/2926832
RUN chmod +x /var && mkdir -p /var/www/
COPY ./face-recognize /var/www/

# Install app dependencies
RUN cd /var/www/face-recognize; npm install

# Binds to port 8080
EXPOSE  8080

#  Defines your runtime(define default command)
# These commands unlike RUN (they are carried out in the construction of the container) are run when the container
CMD ["node", "/src/index.js"]