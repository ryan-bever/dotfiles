# Source in my other rc dotfiles that is shared with bash and zsh
if [ -f ~/.pathrc ]; then
    source ~/.pathrc
fi

if [ -f ~/.aliasrc ]; then
    source ~/.aliasrc
fi

# Source in my local .bashhrc if it exits
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi


