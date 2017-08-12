NAME = boxy
VERSION = 0.1

.PHONY: all build run clean

all: build

build: 
	docker build -t $(NAME):$(VERSION) .

run: 
	docker run -it $(NAME):$(VERSION)

clean:
	# Delete all stopped containers
	docker ps -q -f status=exited | xargs --no-run-if-empty docker rm
	# Delete all dangling (unused) images
	docker images -q -f dangling=true | xargs --no-run-if-empty docker rmi
