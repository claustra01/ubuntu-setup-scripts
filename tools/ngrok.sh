wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar -xzvf ngrok-v3-stable-linux-amd64.tgz
sudo mv ngrok /usr/local/bin
rm ngrok-v3-stable-linux-amd64.tgz

ngrok --version