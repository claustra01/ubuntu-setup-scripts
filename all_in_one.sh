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


# docker
sudo apt -y install ca-certificates gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt -y update
sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world || err

sudo usermod -aG docker $(whoami)
newgrp docker


# ngrok
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xzvf ngrok-v3-stable-linux-amd64.tgz
sudo mv ngrok /usr/local/bin
rm ngrok-v3-stable-linux-amd64.tgz
ngrok --version || err
echo -e "\e[36m-------- ngrok installed --------\e[m"


# latex
sudo apt install -y texlive-full
tex -version || err
echo -e "\e[36m-------- latex installed --------\e[m"


# sagemath
curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh
source ~/miniforge3/etc/profile.d/conda.sh
conda init
mamba create -n sage sage python=3.12
alias sage="conda activate sage && sage" || err
rm Miniforge3-$(uname)-$(uname -m).sh
sage --version || err
sage -sh -c "pip install pycryptodome pwntools"
echo -e "\e[36m-------- sagemath installed --------\e[m"


# ctf tools
sudo apt -y install file checksec
curl -qsL 'https://install.pwndbg.re' | sh -s -- -t pwndbg-gdb
pwndbg --version || err
echo -e "\e[36m-------- ctf tools installed --------\e[m"


# apt autoremove
sudo apt -y autoremove
echo -e "\e[36m-------- all installation completed! --------\e[m"
