FROM mcr.microsoft.com/devcontainers/base:ubuntu

COPY lib/ /tmp/lib/
RUN make -C /tmp/lib install-packages

USER vscode
RUN make -C /tmp/lib install-tools
USER root

RUN rm -rf /tmp/lib
