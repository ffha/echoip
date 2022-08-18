# Build
FROM golang:1.18-alpine AS build
WORKDIR /go/src/github.com/mpolden/echoip
COPY . .

ENV GO111MODULE=on
RUN make

# Run
FROM alpine
EXPOSE 8080

COPY --from=build /go/bin/echoip /opt/echoip/
COPY html /opt/echoip/html

WORKDIR /opt/echoip
ENTRYPOINT ["/opt/echoip/echoip"]
