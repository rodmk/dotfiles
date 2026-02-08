FROM mcr.microsoft.com/devcontainers/base:ubuntu

COPY packages.txt /tmp/
RUN apt-get update \
    && apt-get install -y $(cat /tmp/packages.txt) \
    && rm -rf /var/lib/apt/lists/* /tmp/packages.txt

RUN curl -fsSL https://claude.ai/install.sh | bash
