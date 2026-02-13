FROM mcr.microsoft.com/devcontainers/base:ubuntu

COPY lib/ /tmp/lib/
USER vscode
RUN bash /tmp/lib/install-deps.sh
USER root

RUN rm -rf /tmp/lib
