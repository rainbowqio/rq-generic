FROM gcr.io/blameless-185322/qio:0.0.3
LABEL vendor="RainbowQ"
LABEL app="qio"
LABEL version="0.0.2"
WORKDIR /go/src/qio/
COPY ./rainbow.toml .
