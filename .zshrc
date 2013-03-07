autoload -U compinit
compinit

export CLICOLOR=1
export LSCOLORS=cxfxcxdxbxegedabagacad
export RSENSE_HOME=~/.emacs.d/vendor/rsense-0.3/bin/rsense
export GEM_HOME=~/.gem
export GEM_PATH=$GEM_HOME/bin
export HOMEBREW_SBIN
export PATH=$PATH:$GEM_PATH:/usr/local/sbin

git_prompt_info() {
ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "(${ref#refs/heads/})"
}
autoload -U colors
colors

autoload -Uz promptinit
promptinit
prompt walters

#prompt='%m:%{$fg_bold[white]%}%~%{$fg_bold[grey]%}$(git_prompt_info)%{$fg_bold[white]%}%{$reset_color%}%% '
#prompt='%m:%~$(git_prompt_info)%% '
#if [ -n "$SSH_CLIENT" ]; then
#  prompt='%{$fg_bold[cyan]%}@%{$fg_bold[yellow]%}%m%{$fg_bold[cyan]%}:%~$(git_prompt_info)%{$reset_color%}%% '
#fi

source ~/.aliases

# Rake completions
_rake () {
  if [ -f Rakefile ]; then
    compadd `rake --silent --tasks | cut -d " " -f 2`
  fi
}
compdef _rake rake

# Cap completions
_cap () {
  if [ -f Capfile ]; then
    compadd `cap --tasks --verbose | grep '^cap ' | cut -d " " -f 2`
  fi
}
compdef _cap cap

# History options
setopt APPEND_HISTORY
setopt CORRECT     # command CORRECTION
setopt EXTENDED_HISTORY   # puts timestamps in the history

# number of lines kept in history
export HISTSIZE=10000

# number of lines saved in the history after logout
export SAVEHIST=10000

# location of history
export HISTFILE=~/.zhistory

# history options
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_allow_clobber
setopt hist_reduce_blanks

bindkey -v
