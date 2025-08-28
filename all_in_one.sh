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
sudo apt -y install python3
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
echo -e "\e[36m-------- docker installed --------\e[m"


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
mamba create -n sage sage python=3.12
rm Miniforge3-$(uname)-$(uname -m).sh
conda init
source $(conda info --base)/etc/profile.d/conda.sh
conda activate sage
sage --version || err
if [ -z "$SAGE_ROOT" ]; then
  echo 'export SAGE_ROOT=$(conda info --base)/envs/sage' >> ~/.bashrc
  echo 'export PATH=$SAGE_ROOT/bin:$PATH' >> ~/.bashrc
fi
sage -sh -c "pip install pycryptodome pwntools"
echo -e "\e[36m-------- sagemath installed --------\e[m"


# ctf tools
sudo apt -y install file checksec
curl -qsL 'https://install.pwndbg.re' | sh -s -- -t pwndbg-gdb
pwndbg --version || err
echo -e "\e[36m-------- ctf tools installed --------\e[m"


# apt autoremove
sudo apt -y autoremove
echo -e "\e[36m-------- all installation completed! reboot terminal! --------\e[m"
