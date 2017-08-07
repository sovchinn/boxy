FROM alpine:edge

MAINTAINER Serge Ovchinnikov (sovchinn@gmail.com)

ENV HOME /root
RUN apk add --update-cache \
    curl \
    git \
    go \
    make \
    neovim \
    python3 \
    libc-dev \
    zsh 
RUN git clone --recursive https://github.com/sovchinn/dot.git $HOME/dot 
WORKDIR $HOME/dot
RUN make
WORKDIR $HOME
ENV SHELL /bin/zsh

CMD ["zsh"] 
