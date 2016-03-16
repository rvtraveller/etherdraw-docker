FROM debian:jessie

RUN apt-get update && apt-get install -y \
    libgif-dev \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg62-turbo-dev \ 
    git \
    build-essential \
    g++

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash

RUN /root/.nvm/nvm.sh install 0.10.42 && /root/.nvm/nvm.sh use 0.10.42

RUN mkdir /home/etherdraw
RUN groupadd --gid 6000 etherdraw
RUN useradd -d /home/etherdraw -p etherdraw -g etherdraw --uid 6000 etherdraw

RUN git clone git://github.com/JohnMcLear/draw.git /home/etherdraw/draw/

RUN chown -R etherdraw.etherdraw /home/etherdraw

RUN ["/bin/bash", "-c", "source ~/.profile"]

USER etherdraw
ENTRYPOINT ["/home/etherdraw/draw/bin/run.sh"]

EXPOSE 9002

