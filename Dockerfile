FROM --platform=$BUILDPLATFORM golang:1.18 AS build
ARG TARGETOS
ARG TARGETARCH
WORKDIR /workspace
COPY . .
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH make build

FROM scratch
COPY --from=build /workspace/build/tendermint-readiness /tendermint-readiness

ENTRYPOINT ["/tendermint-readiness"]
