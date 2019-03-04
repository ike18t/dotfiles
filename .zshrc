# Comment this out to disable bi-weekly auto-update check for ohmyzsh
DISABLE_AUTO_UPDATE="true"

# https://github.com/creationix/nvm/issues/1652
export PATH="/usr/local/bin:$(getconf PATH)"

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
export PATH=/usr/local/bin:$PATH:/usr/include:/usr/local/sbin
export EDITOR=vim
eval "$(rbenv init -)"

# source $HOME/.init_iam
source $HOME/.aliases
if [ -e $HOME/.adp_proxy ]
then
  source $HOME/.adp_proxy
fi

export ANDROID_HOME=/Users/Ike/Development/android-sdks
export PATH=$PATH:$ANDROID_HOME:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

set -o vi
bindkey '^R' history-incremental-search-backward

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# export NVM_DIR="$HOME/.nvm"
# . "$(brew --prefix nvm)/nvm.sh"

declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

NODE_GLOBALS+=("node")
NODE_GLOBALS+=("nvm")

load_nvm () {
    export NVM_DIR="$HOME/.nvm"
    . "$(brew --prefix nvm)/nvm.sh"
}

for cmd in "${NODE_GLOBALS[@]}"; do
    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
