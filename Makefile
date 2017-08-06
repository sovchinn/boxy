NAME = boxy
VERSION = 0.1

.PHONY: all build run

all: build

build: 
	docker build -t $(NAME):$(VERSION) .

run: 
	docker run -it $(NAME):$(VERSION)
