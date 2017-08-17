FROM debian:latest

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
 
# Install prerequisites
RUN apt-get update \
 && apt-get install curl build-essential libssl-dev git -y


# Install Node.js
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
RUN source ~/.nvm/nvm.sh; \
    nvm install node && \
    nvm use node && \
    npm install -g node-gyp

# Install Wiki.js

WORKDIR /var/www/wiki

RUN source ~/.nvm/nvm.sh; \
    npm install https://github.com/Requarks/wiki.git#v1.0.6

# Run configure
#RUN node wiki configure

COPY entrypoint.sh entrypoint.sh
COPY config.yml config.yml

CMD ["/var/www/wiki/entrypoint.sh"]
EXPOSE 3000
