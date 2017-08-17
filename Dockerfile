FROM debian:latest

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
 
# Install prerequisites
RUN apt-get update
RUN apt-get install curl build-essential libssl-dev -y

# Install Node.js
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
RUN source ~/.nvm/nvm.sh; \
    nvm install node && \
    nvm use node && \
    npm install -g node-gyp

# Install Wiki.js
RUN mkdir -p /var/www/wiki
WORKDIR /var/www/wiki
RUN source ~/.nvm/nvm.sh; \
    npm install wiki.js@1.0.4


COPY entrypoint.sh /var/www/wiki/entrypoint.sh
ENTRYPOINT ["/var/www/wiki/entrypoint.sh"]
EXPOSE 3000
