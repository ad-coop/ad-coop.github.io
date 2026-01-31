FROM debian:bookworm-slim

ARG HUGO_VERSION
ARG TARGETARCH

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN ARCH=$(echo ${TARGETARCH} | sed 's/amd64/amd64/;s/arm64/arm64/') && \
    wget -O /tmp/hugo.deb "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${ARCH}.deb" && \
    dpkg -i /tmp/hugo.deb && \
    rm /tmp/hugo.deb

WORKDIR /site
EXPOSE 1313

CMD ["hugo", "server", "--bind", "0.0.0.0"]
