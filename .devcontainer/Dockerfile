FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install system packages defined in packages.txt
COPY lib/packages.txt /tmp/
RUN apt-get update \
    && apt-get install -y $(cat /tmp/packages.txt) \
    && rm -rf /var/lib/apt/lists/* /tmp/packages.txt

# Install Claude Code CLI as the non-root vscode user
USER vscode
RUN curl -fsSL https://claude.ai/install.sh | bash
USER root
