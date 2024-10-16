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


brew install zsh
brew install starship


# python
# brew install pyenv
# brew install pyenv-virtualenv



# utils
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
brew install scroll-reverser
brew install the_silver_searcher
brew install diffmerge
brew install macvim
brew install watch
brew install fswatch
brew install tree
brew install telnet
brew install jq
brew install yq
brew install sshrc
brew install meld
brew install wget
brew install speedtest-cli
# brew install rectangle
brew install bato
brew install mise
brew install shellcheck
# brew install vault
brew install direnv

# https://github.com/atuinsh/atuin
# bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)
brew install atuin



# go and k8s and aws
brew install go
brew install kubectl
brew install awscli

# Installs to ~/go/bin/dlv
go install github.com/go-delve/delve/cmd/dlv@latest
# Enabel developer mode so goland debugger doesn't ask for password
# See:  https://stackoverflow.com/questions/19626856/alertdeveloper-tools-access-needs-to-take-control-of-another-process-for-debugg
DevToolsSecurity -enable


# Show dotfiles
defaults write com.apple.Finder AppleShowAllFiles true; killall Finder
