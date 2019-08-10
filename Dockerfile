
#build stage
FROM golang:alpine AS builder
WORKDIR /go/src/app
COPY . /go/src/github.com/stijnv1/GoHelloWorld/
WORKDIR /go/src/github.com/stijnv1/GoHelloWorld/
RUN apk add --no-cache git
RUN go get -d -v ./...
RUN go build -o /go/bin/app /go/src/github.com/stijnv1/GoHelloWorld/cmd/helloazurevm/main.go

#final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /go/bin/app /app
ENTRYPOINT ./app
LABEL Name=gohelloworld Version=0.0.1
EXPOSE 8000
