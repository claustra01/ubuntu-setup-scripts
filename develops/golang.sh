sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt -y install golang
echo "export PATH=\"$HOME/go/bin:$PATH\"" > ~/.bashrc
source ~/.bashrc

go version
