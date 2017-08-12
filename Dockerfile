FROM ubuntu:latest

MAINTAINER Serge Ovchinnikov (sovchinn@gmail.com)

ENV HOME /root

# Install core package
RUN apt-get update -qy && apt-get install -qy \
    git \
    make \
    zsh \
    curl 

# Install Neovim
RUN apt-get install -qy \
    software-properties-common &&\
    add-apt-repository ppa:neovim-ppa/stable &&\
    apt-get update &&\
    apt-get install -qy \
    neovim

# Prepare environment for Neovim
RUN apt-get -qy install \
    python3-pip &&\
    apt-get install -qy \
    language-pack-en-base &&\
    pip3 install --upgrade pip &&\
    pip3 install neovim 

# Install Neovim plugins
RUN nvim +PlugInstall +qall &>/dev/null

# Install Go
RUN curl -O https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz &&\
    tar -xf go1.8.3.linux-amd64.tar.gz &&\
    mv go /usr/local &&\
    rm go1.8.3.linux-amd64.tar.gz 

# Install dot files
RUN git clone --recursive https://github.com/sovchinn/dot.git $HOME/dot 
WORKDIR $HOME/dot
RUN make
WORKDIR $HOME
ENV SHELL /bin/zsh

CMD ["zsh"] 
