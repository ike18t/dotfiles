# Comment this out to disable bi-weekly auto-update check for ohmyzsh
# DISABLE_AUTO_UPDATE="true"

# https://github.com/creationix/nvm/issues/1652
export PATH="/usr/local/bin:/opt/homebrew/bin:$(getconf PATH)"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
unsetopt correct_all
setopt CORRECT

# Customize to your needs...
export HOMEBREW_SBIN
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color
export COLORTERM="truecolor"
export EDITOR=vim

source $HOME/.aliases

set -o vi
bindkey '^R' history-incremental-search-backward

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
export PATH="/usr/local/sbin:$PATH"

eval "$(/usr/local/bin/mise activate zsh)"
