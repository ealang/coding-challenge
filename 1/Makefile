.PHONY: all
all: build

.PHONY: lint
lint:
	pylint --rcfile=pylintrc src

.PHONY: test
test:
	pytest

.PHONY: build
build: lint test
	docker build -t challenge-1 .

.PHONY: run
run:
	gunicorn -c gunicorn.py --bind 127.0.0.1:8000 src.server:app
