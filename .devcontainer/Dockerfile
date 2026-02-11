FROM mcr.microsoft.com/devcontainers/base:ubuntu

COPY lib/ /tmp/lib/
USER vscode
RUN make -C /tmp/lib install
USER root

RUN rm -rf /tmp/lib
