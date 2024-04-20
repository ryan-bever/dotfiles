# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Source in my other rc dotfiles that is shared with bash and zsh
if [ -f ~/.zshrc.pathrc ]; then
    source ~/.zshrc.pathrc
fi

# Prevent escaping when urls are pasted into zsh shell
# See: https://github.com/ohmyzsh/ohmyzsh/issues/7632
DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Prevent zsh from showing highlighted % on uncompleted output
# See: https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
PROMPT_EOL_MARK=''


# User configuration
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob notify
unsetopt share_history
unsetopt autocd beep
bindkey -v

# Tell zsh not to trust it's command completion cache
# see: https://unix.stackexchange.com/questions/2179/rebuild-auto-complete-index-or-whatever-its-called-and-binaries-in-path-cach
zstyle ":completion:*:commands" rehash 1

# Preferred editor for local and remote sessions
export VISUAL='vim'
export EDITOR='vim'


# 
# Load zap plugins
# See: https://github.com/zap-zsh/zap
#
# zap must be installed with:
# zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
#plug "zsh-users/zsh-autosuggestions"
# plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"

# AUTO_MENU="true"

# plug "zap-zsh/supercharge"
unsetopt MENU_COMPLETE
unsetopt AUTO_CD

# Load and initialise completion system
autoload -Uz compinit
compinit

# Source in aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
if [ -f ~/.zshrc.aliasrc ]; then
    source ~/.zshrc.aliasrc
fi

# Source in my local .zshrc.secrets if it exits
# This file should not be checked into source control
if [ -f ~/.zshrc.secrets ]; then
    source ~/.zshrc.secrets
fi

# Source in my local .zshrc if it exits
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# Source in completions
# Note this must be done after sourcing in .zshrc.local if .zshrc.local contains a eval "$(mise activate zsh)" as
# that is clobbering the completions.
if [ -f ~/.zshrc.completions ]; then
    source ~/.zshrc.completions
fi
