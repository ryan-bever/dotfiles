# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Source in my other rc dotfiles that is shared with bash and zsh
if [ -f ~/.pathrc ]; then
    source ~/.pathrc
fi

# Add path to my custom .completions dir to fpath so zsh will load them automatically
# See: https://unix.stackexchange.com/questions/33255/how-to-define-and-load-your-own-shell-function-in-zsh
# To add a completion file just put it in that dir e.g. `operator-sdk completion zsh > ~/.completions/operator-sdk.zsh`
fpath=( ~/.completions "${fpath[@]}" )

# Prevent escaping when urls are pasted into zsh shell
# See: https://github.com/ohmyzsh/ohmyzsh/issues/7632
DISABLE_MAGIC_FUNCTIONS=true

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
#

# Prevent zsh from showing highlighted % on uncompleted output
# See: https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
PROMPT_EOL_MARK=''


######################################
# pyenv settings
######################################
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# Updated see: https://stackoverflow.com/a/68228627
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
# See: https://github.com/pyenv/pyenv/issues/1740
export LDFLAGS="-L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/bzip2/include"

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
  copypath
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
  oc
  minikube
  helm
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
  export VISUAL='vim'
  export EDITOR='vim'
else
  export VISUAL='vim'
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

# Source in my local .zshrc.secrets if it exits
# This file should not be checked into source control
if [ -f ~/.zshrc.secrets ]; then
    source ~/.zshrc.secrets
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

# rbever: I have 3 different p10k configs to choose from uncomment only one:
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh.lean ]] || source ~/.p10k.zsh.lean
[[ ! -f ~/.p10k.zsh.classic ]] || source ~/.p10k.zsh.classic
# [[ ! -f ~/.p10k.zsh.rainbow ]] || source ~/.p10k.zsh.rainbow

