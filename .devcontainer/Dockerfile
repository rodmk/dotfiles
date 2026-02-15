FROM mcr.microsoft.com/devcontainers/base:ubuntu

ENV PATH="/home/vscode/.local/bin:${PATH}"

COPY --chown=vscode:vscode . /tmp/dotfiles/
USER vscode
RUN /tmp/dotfiles/install.sh && bash /tmp/dotfiles/lib/install-deps.sh
USER root

RUN rm -rf /tmp/dotfiles
