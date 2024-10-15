# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Source in my other rc dotfiles that is shared with bash and zsh
if [ -f ~/.zshrc.pathrc ]; then
    source ~/.zshrc.pathrc
fi

# Prevent zsh from showing highlighted % on uncompleted output
# See: https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
PROMPT_EOL_MARK=''


# User configuration
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY 
setopt HIST_EXPIRE_DUPS_FIRST
setopt BANG_HIST
setopt EXTENDED_GLOB
setopt NOTIFY
unsetopt SHARE_HISTORY
unsetopt AUTO_CD 
unsetopt BEEP
bindkey -v
# Allows writing comments into a shell output instead of getting `zsh: bad pattern: #`
setopt INTERACTIVE_COMMENTS

#
# Command Completion Options
#
# This menu completion style requires a double tab press; instead of inserting the first selection automaticially.
# See: man zshoptions
zstyle ':completion:*' menu select
setopt AUTO_MENU
unsetopt MENU_COMPLETE

# Tell zsh not to trust it's command completion cache
# see: https://unix.stackexchange.com/questions/2179/rebuild-auto-complete-index-or-whatever-its-called-and-binaries-in-path-cach
zstyle ":completion:*:commands" rehash 1

# Load and initialise completion system
autoload -Uz compinit
compinit


# 
# Load zap plugins
# See: https://github.com/zap-zsh/zap
#
# zap must be installed with:
# zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
# plug "zsh-users/zsh-autosuggestions"
# plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "fdellwing/zsh-bat"
plug "agkozak/zsh-z"


# Preferred editor for local and remote sessions
export VISUAL='vim'
export EDITOR='vim'

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

# Set XDG_CONFIG_HOME for applications that support it
export XDG_CONFIG_HOME="$HOME/.config"

# Start starship prompt
eval "$(starship init zsh)"

eval "$(atuin init zsh)"
. "$HOME/.atuin/bin/env"
