REGISTRY=registry.gitlab.com/dcreemer
NAME=nginx-proxy

build:
	docker build -t $(REGISTRY)/$(NAME) .

push:
	docker push $(REGISTRY)/$(NAME)
