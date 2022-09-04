# Build
FROM golang AS build
WORKDIR /go/src/github.com/mpolden/echoip
COPY . .

ENV GO111MODULE on
ENV CGO_ENABLED 0
RUN make

# Run
FROM debian:stable-slim
EXPOSE 8080

COPY --from=build /go/bin/echoip /opt/echoip/
COPY html /opt/echoip/html
WORKDIR /opt/echoip
RUN apt-get update && apt-get install -y tini
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD /opt/echoip/echoip -H X-forwarded-for
