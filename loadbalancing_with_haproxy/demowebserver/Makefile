default: compile builddocker

VERSION=$(shell cat VERSION)
BINARY_NAME=demowebserver

compile:
#	docker run --rm -v $(shell pwd):/go/src/_/gopath1.5/src/checkip golang:1.5 /bin/bash -c "cd /go/src/_/gopath1.5/src/checkip && pkgName=checkip CGO_ENABLED=\${CGO_ENABLED:-0} go build -a --installsuffix cgo --ldflags='\${LDFLAGS:--s}' \${pkgName}"
	docker run --rm -e BINARY_NAME=$(BINARY_NAME) -v $(shell pwd):/go/src/$(BINARY_NAME) golang:1.5 /bin/bash -c "cd /go/src/${BINARY_NAME} && CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags='-s' ${BINARY_NAME}"

builddocker:
	docker build -t firecyberice/$(BINARY_NAME) .

pushdocker:
	docker tag -f firecyberice/$(BINARY_NAME) firecyberice/$(BINARY_NAME):$(VERSION)
	docker push firecyberice/$(BINARY_NAME):$(VERSION)
	docker rmi firecyberice/$(BINARY_NAME):$(VERSION)
	
test:
	docker run -d --name $(BINARY_NAME) firecyberice/$(BINARY_NAME) || true
	docker run -a stdout --name test-$(BINARY_NAME) -e BINARY_NAME=$(BINARY_NAME) --link $(BINARY_NAME):$(BINARY_NAME) busybox sh -c "wget -qO - http://${BINARY_NAME}"
	
cleanup:
	docker rm -vf test-$(BINARY_NAME) $(BINARY_NAME) || true
	rm -f $(BINARY_NAME)
	
	