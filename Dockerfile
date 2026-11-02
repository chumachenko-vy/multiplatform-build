FROM quay.io/projectquay/golang:1.22 AS builder

WORKDIR /go/src/app
COPY . .

ARG TARGETOS
ARG TARGETARCH

RUN make test
RUN make build TARGETOS=${TARGETOS} TARGETARCH=${TARGETARCH}

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/app /app
ENTRYPOINT ["/app"]
