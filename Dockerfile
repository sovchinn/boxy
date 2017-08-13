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
    python-dev \
    python-pip \ 
    python3-dev \
    python3-pip &&\
    apt-get install -qy \
    language-pack-en-base &&\
    pip2 install --upgrade pip &&\
    pip2 install --upgrade neovim &&\
    pip3 install --upgrade pip &&\
    pip3 install --upgrade neovim 

# Install plugins using vim
RUN nvim +PlugInstall +qall 

# Install Go
RUN curl -O https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz &&\
    tar -xf go1.8.3.linux-amd64.tar.gz &&\
    mv go /usr/local &&\
    rm go1.8.3.linux-amd64.tar.gz 

# Install dot files
RUN git clone --recursive https://github.com/sovchinn/dot.git $HOME/dot 
WORKDIR $HOME/dot
RUN make
RUN echo "let g:python_host_prog='/usr/bin/python2'" >> $HOME/.config/nvim/init.vim &&\
    echo "let g:python3_host_prog='/usr/bin/python3'" >> $HOME/.config/nvim/init.vim  
WORKDIR $HOME
ENV SHELL /bin/zsh

CMD ["zsh"] 
