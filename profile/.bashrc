###############################################################################
#
# Custom .bashrc
# Author: Mick Clarke 2017-2019
#
###############################################################################
# general settings
###############################################################################
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
# Set the system editor
export EDITOR='vim'
# Set a consistent TERM (tmux vs vim)
export TERM="xterm-256color"
# make sure man is pretty and readable
export PAGER="/usr/bin/most -s"

# Configure the prompt.
# Goal: simple, so:
#   dir_name [optional] git branch [optional] language symbol version
# set a fancy prompt (non-color, unless we know we "want" color)
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\w\[\033[00m\]\$ '
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh

###############################################################################
# aliases
###############################################################################
[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases

###############################################################################
# completions
###############################################################################
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
# FIXME this throws an error at login...
if [[ "$-" =~ "i" ]]; then
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
  bind '"\eOA": history-search-backward'
  bind '"\eOB": history-search-forward'
fi

###############################################################################
# File manager configuration - `nnn`
###############################################################################
# nnn cd on exit
export NNN_TMPFILE="/tmp/nnn"
# nnn copy - TODO doesn't work!
export NNN_COPIER='$HOME/.my-settings/scripts/nnn-copy.sh'
n()
{
   nnn "$@"
   if [ -f $NNN_TMPFILE ]; then
     . $NNN_TMPFILE
     rm $NNN_TMPFILE
   fi
}

###############################################################################
# Rust
###############################################################################
source $HOME/.cargo/env
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/
# export RUSTC_WRAPPER=sccache

###############################################################################
###############################################################################
# API tokens (local only!)

# Completions
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
# asdf settings for Java
. $HOME/.asdf/plugins/java/asdf-java-wrapper.bash

# Added by Krypton
