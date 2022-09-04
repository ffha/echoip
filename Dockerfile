# Build
FROM golang:bullseye AS build
WORKDIR /go/src/github.com/mpolden/echoip
COPY . .
ENV GO111MODULE=on
RUN make

# Run
FROM debian:stable-slim
EXPOSE 8080

COPY --from=build /go/bin/echoip /app/echoip
COPY html /app/html

WORKDIR /opt/echoip
ENTRYPOINT ["/app/echoip"]
