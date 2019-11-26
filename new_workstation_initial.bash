#!/bin/bash  -ex


sudo -v 
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo apt update

#
# zsh
#
sudo apt install -y zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --batch
# git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k


# allows one to use chsh or anything else that requires a user in the passwd file.  This works well and yes authentication for sudo/ldap/etc remain unaffected
# see: https://confluence.ngage.netapp.com/pages/viewpage.action?pageId=137407364
if [ ! grep -q $(id -un) /etc/passwd]; then
  getent passwd $(id -un) | sudo tee -a /etc/passwd
fi
chsh /usr/bin/zsh


# Do homedir hack
# https://confluence.ngage.netapp.com/display/SFI/Home+Directory+work-around
# NOTE: The bash script will add another entry to /etc/passwd for user - just go edit the one from above with zsh and point it at /home/rbever and remove the secone one


# Switch desktop to Mate to avoid gnome flashing problem






#
# shell and vim
#
sudo apt install -y terminator
sudo apt install -y vim-gnome


#
# python
#
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
~/.pyenv/bin/pyenv install 3.7.4
~/.pyenv/bin/pyenv global 3.7.4




#
# utils
#
sudo apt install -y silversearcher-ag
sudo apt install -y jq
sudo apt install -y gnome-tweak-tool




#
# docker
#
# bash <(curl -fsSL https://get.docker.com)
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker rbever


#
# chrome
#
wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb


# bin
cd
git clone https://bitbucket.ngage.netapp.com/scm/\~rbever/mac-bin.git bin
cd bin
pyenv virtualenv 3.7.4 bin
pyenv local bin
