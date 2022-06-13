#!/bin/bash  -x


# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
sudo -v 
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"



# Pin the version of git that doesn't clobber autocomplete
# 10/3/19 - Temporarily don't install git from brew because it's slow as shit at work when using vcs plugin of powerlevel9k...
# brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/db579a4f633c3dfde12c5236b9ea0695dce6cc5e/Formula/git.rb --without-completions
# brew pin git


# Set brew to not update on every call during this script
HOMEBREW_NO_AUTO_UPDATE=1

brew install git
brew install iterm2 
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font


brew install zsh zsh-completions


# oh-my-zsh is going to do this 
# chsh -s $(which zsh)


sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --batch


# git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k





# python
brew install pyenv
brew install pyenv-virtualenv



# utils
brew install scroll-reverser
brew install the_silver_searcher
brew install diffmerge
brew install macvim
brew install watch
brew install fswatch
brew install telnet
brew install jq
brew install python-yq
brew install sshrc
brew install meld
brew install wget
brew install speedtest-cli



# go and k8s and aws
brew install go
brew install kubectl
brew install awscli


# Enabel developer mode so goland debugger doesn't ask for password
# See:  https://stackoverflow.com/questions/19626856/alertdeveloper-tools-access-needs-to-take-control-of-another-process-for-debugg
DevToolsSecurity -enable


# Show dotfiles
defaults write com.apple.Finder AppleShowAllFiles true; killall Finder
