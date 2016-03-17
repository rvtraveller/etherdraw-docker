FROM debian:jessie

RUN apt-get update && apt-get install -y \
    libgif-dev \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg62-turbo-dev \
    git \
    build-essential \
    g++

ENV HOME_PATH /srv/etherdraw
RUN mkdir $HOME_PATH
RUN groupadd --gid 6000 etherdraw
RUN useradd -d $HOME_PATH -r -g etherdraw --uid 6000 etherdraw

RUN chown -R etherdraw:etherdraw $HOME_PATH
USER etherdraw

RUN git clone https://github.com/JohnMcLear/draw.git --depth=1 -b develop $HOME_PATH/draw/

ENV NVM_DIR $HOME_PATH/nvm
ENV NODE_VERSION 0.12.12
WORKDIR $HOME_PATH/draw

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && $HOME_PATH/draw/bin/installDeps.sh

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

ENTRYPOINT ["node", "/srv/etherdraw/draw/server.js"]
EXPOSE 9002

