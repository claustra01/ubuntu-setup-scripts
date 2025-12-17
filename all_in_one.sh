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
sudo apt -y install python3 python3-pip
python3 --version || err

pip install pycryptodome pwntools ROPgadget --break-system-packages
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


# php
sudo apt -y install php php-cli php-mbstring php-xml
php --version || err

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv ./composer.phar $(dirname $(which php))/composer && chmod +x "$_"
composer --version || err
echo -e "\e[36m-------- php installed --------\e[m"


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


# cloudflared
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
sudo mv cloudflared-linux-amd64 /usr/local/bin/cloudflared
sudo chmod +x /usr/local/bin/cloudflared
cloudflared --version || err
echo -e "\e[36m-------- cloudflared installed --------\e[m"


# latex
sudo apt install -y texlive-full
tex -version || err
echo -e "\e[36m-------- latex installed --------\e[m"


# marp
npm install -g @marp-team/marp-cli
marp --version || err


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
sudo apt -y install file checksec patchelf ltrace strace binwalk tshark openssl hashcat
curl -qsL 'https://install.pwndbg.re' | sh -s -- -t pwndbg-gdb
pwndbg --version || err
echo -e "\e[36m-------- ctf tools installed --------\e[m"


# apt autoremove
sudo apt -y autoremove
echo -e "\e[36m-------- all installation completed! reboot terminal! --------\e[m"
