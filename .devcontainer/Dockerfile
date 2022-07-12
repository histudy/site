FROM mcr.microsoft.com/vscode/devcontainers/base:0-bullseye

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends vim direnv ansible hugo \
    && mkdir -p /etc/ansible \
    && echo "localhost ansible_connection=local" >/etc/ansible/hosts

USER vscode

RUN echo 'eval "$(direnv hook bash)"' >>~/.bashrc && echo 'eval "$(direnv hook zsh)"' >>~/.zshrc

