FROM alpine:edge

MAINTAINER Serge Ovchinnikov (sovchinn@gmail.com)

RUN apk add --update-cache \
    git \
    neovim \
    zsh
RUN git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
RUN for rc in $HOME/.zprezto/runcoms/z* ; do \
    ln -s "${rc}" "$HOME/.$(basename $rc)" ; done &&\
    echo 'unalias ls'>>$HOME/.zshrc  &&\
    exec zsh && setopt EXTENDED_GLOB 

ENV SHELL /bin/zsh

CMD ["zsh"] 
