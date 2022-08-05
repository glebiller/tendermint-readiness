FROM scratch
COPY tendermint-readiness /tendermint-readiness
ENTRYPOINT ["/tendermint-readiness"]
