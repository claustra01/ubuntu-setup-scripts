#!/bin/bash

function err() {
  echo -e "\e[31m-------- error: reboot terminal and try again! --------\e[m"
  exit 1
}


# apt update
sudo apt -y update
sudo apt -y upgrade
echo -e "\e[36m-------- apt update complete --------\e[m"


# utils
sudo apt -y install \
    git curl wget make zip unzip tar
echo -e "\e[36m-------- utils installed --------\e[m"


# build-essential
sudo apt -y install build-essential
gcc --version || err
echo -e "\e[36m-------- build-essential installed --------\e[m"


# nodejs
curl https://get.volta.sh | bash
source ~/.bashrc
volta --version || err
volta install node

node --version || err
volta install pnpm
pnpm --version || err
echo -e "\e[36m-------- nodejs installed --------\e[m"


# python3
rm -rf ~/.pyenv
curl -fsSL https://pyenv.run | bash
if [ -z "$PYENV_ROOT" ]; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init - bash)"' >> ~/.bashrc
fi
source ~/.bashrc
pyenv --version || err

sudo apt -y install \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
latest=$(pyenv install --list | grep -E "^\s*[0-9]+\.[0-9]+\.[0-9]+$" | tail -1 | tr -d ' ')
pyenv install $latest
pyenv global $latest
python3 --version || err

curl -sSL https://install.python-poetry.org | python3 -
poetry --version || err
echo -e "\e[36m-------- python3 installed --------\e[m"


# golang
sudo rm -rf /usr/local/go
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt -y install golang
if [ -z "$GOPATH" ]; then
  echo 'export GOPATH=$HOME/go' >> ~/.bashrc
  echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
fi
source ~/.bashrc
go version || err
echo -e "\e[36m-------- golang installed --------\e[m"


# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo --version || err
echo -e "\e[36m-------- rust installed --------\e[m"

