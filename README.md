# Tendermint Readiness

Provide a small, single-binary executable that act as a readiness probe for tendermint chains.  
When executed, it queries the local Tendermint RPC endpoint `http://localhost:26657/status` 
and look for the `.result.sync_info.catching_up`.

The node is considered ready, only if the node is not catching up the blockchain.

## Usage

First package the binary along with your blockchain binary.
```dockerfile
FROM golang:1.18 AS build
# Build tendermint chain binary

FROM ghcr.io/glebiller/tendermint-readiness:latest as tendermint-readiness

FROM scratch
COPY --from=build /build/tendermint /tendermint
COPY --from=tendermint-readiness /tendermint-readiness /tendermint-readiness
```

Then register a livenessProbe and a readinessProbe.
```yaml
spec:
  template:
    spec:
      containers:
          livenessProbe:
            httpGet:
              port: 26657
              path: /health
          readinessProbe:
            exec:
              command:
                - /tendermint-readiness
```