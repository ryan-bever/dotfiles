#!/bin/bash  -ex
#
# sfprime
#
mkdir -p ~/git
cd ~/git
git clone https://bitbucket.ngage.netapp.com/scm/hmgmt/sfprime.git
cd ~/git/sfprime
pyenv install 3.5.3
pyenv virtualenv 3.5.3 sfprime
pyenv local sfprime
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv activate sfprime
pip install --upgrade pip
pip install -r requirements.txt
sudo touch /var/log/sf-nde.info
sudo chown rbever:adm /var/log/sf-nde.info

# Set logrotate on nde
sudo tee /etc/logrotate.d/sf-nde > /dev/null <<EOL
/var/log/sf-nde.info {
        size 10m
        create 700 rbever adm
        rotate 4
}
EOL
