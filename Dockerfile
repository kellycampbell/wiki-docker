FROM debian:latest

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
 
# Install prerequisites
RUN apt-get update \
 && apt-get install curl build-essential libssl-dev git python -y


# Install Node.js
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
RUN source ~/.nvm/nvm.sh; \
    nvm install --lts node && \
    nvm use --lts node && \
    npm install -g node-gyp && \
    npm install -g yarn 


# Install Wiki.js

WORKDIR /var/www

RUN source ~/.nvm/nvm.sh; \
    git clone https://github.com/Requarks/wiki.git ; \
    export NODE_ENV=DEVEL ; \
    cd wiki ; \
    git checkout v1.0.68 ; \
    yarn install ; \
    yarn run build

WORKDIR /var/www/wiki

# Run configure
#RUN node wiki configure

COPY entrypoint.sh entrypoint.sh
COPY config.yml config.yml

CMD ["/var/www/wiki/entrypoint.sh"]
EXPOSE 3000
