#!/bin/bash  -x


sudo -v 
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


#
# zsh
#
sudo apt install -y zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --batch
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k





#
# python
#
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
~/.pyenv/bin/pyenv install 3.7.2
~/.pyenv/bin/pyenv global 3.7.2




#
# utils
#
sudo apt install -y silversearcher-ag
sudo apt install -y jq




#
# docker
#
bash <(curl -fsSL https://get.docker.com)
sudo usermod -aG docker rbever

