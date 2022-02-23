FROM golang:1.17-alpine as helper
WORKDIR /go/src/
COPY . .
RUN CGO_ENABLED=0 GOFLAGS=-mod=vendor go build -ldflags="-s -w" -trimpath .

FROM gcr.io/distroless/static:latest-amd64

COPY --from=helper /go/src/http-hello-world /.

EXPOSE 8080
CMD ["/http-hello-world"]
