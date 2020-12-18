# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Source in my other rc dotfiles that is shared with bash and zsh
if [ -f ~/.pathrc ]; then
    source ~/.pathrc
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="spaceship"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
ZSH_THEME="powerlevel10k/powerlevel10k"


######################################
# Powerlevel9k
######################################
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv history command_execution_time time)

if [ "$(uname)" = "Linux" ]; then
    # If Linux assume I'm on a remote system - show the host icon which includes ssh indicator
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon host dir vcs)
fi

# This if statement is to work-around some problem with using material theme in pycharm on Linux and Mac
# This is probably not the best method, but it works for now.  
USING_MATERIAL_THEME="false"
if [ "${USING_MATERIAL_THEME}" = "true" ]; then
    if [ "$(uname)" = "Darwin" ]; then
        # For Mac the only difference I have found in env is that TERM_PROGRAM is set to iTerm.app or Apple_Terminal
        # for the two terminal programs that I use.  This variable is unset in pycharm - but it's safe to do this 
        # even if we are not in pycharm
        if [ -z "$TERM_PROGRAM" ]; then
            POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs virtualenv)
            POWERLEVEL9K_DISABLE_RPROMPT=true
        fi
    elif [ "$(uname)" = "Linux" ]; then
        # I am assuming that /home/rbever/.local/share/applications/jna_jar.desktop is the ubuntu launcher file for pycharm. 
        # For terminator it is /usr/share/applications/terminator.desktop
        # For Gnome terminal it is unset
        #echo "GIO_LAUNCHED_DESKTOP_FILE=$GIO_LAUNCHED_DESKTOP_FILE"
        if [[ "$GIO_LAUNCHED_DESKTOP_FILE" == *"jna_jar.desktop"* ]]; then
            POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs virtualenv)
            POWERLEVEL9K_DISABLE_RPROMPT=true
        fi
    else
        # do nothing
    fi
fi

POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='yellow'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='236'

POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='red'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='red'
POWERLEVEL9K_VCS_SHORTEN_LENGTH=20
POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=20
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"




# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


######################################
# pyenv settings
######################################
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

######################################
# jenv settings
######################################
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  colorize
  copydir
  copyfile
  extract
  # vi-mode   # This enables the v command going to vim in escape mode which I hate
  #zsh-syntax-highlighting
  git
  #git-extras
  docker
  sbt
  scala
  kubectl
  minikube
)

# NOTE: When using zsh git plugins on Mac with brew installed git see these issues:
# https://www.raphael-brugier.com/blog/fix-git-completion-zsh-mac-homebrew/
# https://github.com/Homebrew/homebrew-core/issues/32081
# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git-extras#os-x-homebrew-setup

source $ZSH/oh-my-zsh.sh

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


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
# Enable tab completion for sshrc
compdef sshrc=ssh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
if [ -f ~/.aliasrc ]; then
    source ~/.aliasrc
fi


# Source in my local .zshrc if it exits
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# The next line enables shell command completion for gcloud.
# Source in .gcloudrc if it exists
if [ -f ~/.gcloudrc ]; then
    source ~/.gcloudrc
fi
if [ -f '/Users/rbever/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rbever/bin/google-cloud-sdk/completion.zsh.inc'; fi


source /Users/rbever/.config/broot/launcher/bash/br


