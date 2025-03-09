FROM mcr.microsoft.com/vscode/devcontainers/base:debian

# Hugo version
ARG HUGO_VERSION=0.144.2
ARG GO_VERSION=1.21.0

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates \
    curl \
    git \
    wget \
    && wget -O go.tar.gz https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go.tar.gz \
    && rm go.tar.gz \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*    

# Install Hugo
RUN curl -L -o hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb \
    && dpkg -i hugo.deb \
    && rm hugo.deb

ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin