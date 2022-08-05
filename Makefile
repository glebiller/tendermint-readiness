build:
	goreleaser build --rm-dist --single-target --snapshot --output tendermint-readiness
.PHONY: build

package: build
	docker build -t tendermint-readiness:local .
.PHONY: package

clean:
	rm -rf dist/
.PHONY: build
