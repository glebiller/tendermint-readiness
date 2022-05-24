build:
	CGO_ENABLED=0 go build -ldflags="-w -s" -o build/tendermint-readiness cmd/tendermint-readiness/main.go
.PHONY: build

clean:
	rm -rf build/
.PHONY: build
