###############################################################################
#
# Custom .zshrc
# Author: Mick Clarke 2017-2019
#
###############################################################################
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spaceship"

# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

# Source antigen and oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export LC_CTYPE="en_US.UTF-8"

# Completions
fpath+=~/.zfunc; compinit

# Set a consistent TERM (tmux vs vim)
export TERM="xterm-256color"

# General aliases
alias vim='/usr/bin/nvim'
alias rgr='/usr/local/bin/ranger'

# Add exports
# Rust
source $HOME/.cargo/env
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/
# export RUSTC_WRAPPER=sccache

# Prettifiers
export UNCRUSTIFY_CONFIG=$HOME/.uncrustify/avastmick.cfg

# API tokens (local only!)

# Completions
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# nnn cd on exit
export NNN_TMPFILE="/tmp/nnn"
n()
{
        nnn "$@"
        if [ -f $NNN_TMPFILE ]; then
                . $NNN_TMPFILE
                rm $NNN_TMPFILE
        fi
}

# Added by Krypton
export GPG_TTY=$(tty)

# linuxbrew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
