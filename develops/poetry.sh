sudo apt -y install gcc libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev libreadline-dev libbz2-dev libsqlite3-dev
curl https://pyenv.run | bash

if [ -z "$PYENV_ROOT" ]; then
  echo '' >> ~/.bashrc
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
  source ~/.bashrc
fi

pyenv install 3.12.5
pyenv global 3.12.5

curl -sSL https://install.python-poetry.org | python3 -
source ~/.bashrc

pyenv --version
python3 --version
poetry --version
