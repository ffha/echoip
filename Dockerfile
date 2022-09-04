# Build
FROM golang:alpine AS build
WORKDIR /go/src/github.com/mpolden/echoip
COPY . .
RUN apk add --no-cache build-base make bash
ENV GO111MODULE=on
RUN make

# Run
FROM alpine
EXPOSE 8080

COPY --from=build /go/bin/echoip /app/echoip
COPY html /app/html

WORKDIR /opt/echoip
ENTRYPOINT ["/opt/echoip/echoip"]
