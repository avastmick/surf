#!/bin/bash
###############################################################################
# Install script for Ubuntu
#   TODO - idempotence
#        - backup and import keyboard bindings
#        - install st terminal (own config)
###############################################################################
# Bootstrap install:
# git clone https://github.com/avastmick/developer-machine.git .my-settings

###############################################################################
# PPA and external sources
###############################################################################
LAST_LTS = "bionic"
source /etc/os-release;
# Signal - Note: the repository is still set to xenial (16.04 LTS)
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -;
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list;
# Etcher
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 379CE192D401AB61 && sudo sh -c "echo 'deb https://dl.bintray.com/resin-io/debian stable etcher' > /etc/apt/sources.list.d/resin-io-etcher.list";
# Wireguard
sudo add-apt-repository --yes --update ppa:wireguard/wireguard;
# FIXME Shadowsocks 
# sudo apt install libqrencode libappindicator1 libqtshadowsocks libzbar qtbase5;
# Brave browser
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -;
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ ${UBUNTU_CODENAME} main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list;

# Ansible
sudo apt-add-repository --yes --update ppa:ansible/ansible;
# Install NeoVim from ppa as the Debian repo is very old
sudo add-apt-repository --yes --update ppa:neovim-ppa/stable;
###############################################################################
# Start the package installs
###############################################################################
# Update
sudo apt update && sudo apt upgrade -y;

# Install stuff
sudo apt install ansible ccache brave-browser brave-keyring chromium-browser cmake colordiff deluge etcher-electron evolution-ews exuberant-ctags ffmpeg flatpak gnome-software-plugin-flatpak jq libssl-dev mpc mpa mpd most mplayer mpv newsboat ncmpcpp neovim p7zip-full pandoc pandoc-citeproc pass php powertop python3-pip qemu-user-static signal-desktop taskwarrior texlive texlive-fonts-extra texlive-xetex tlp tlp-rdw tmux uget vifm virtualbox virtualbox-ext-pack wdiff wireguard xclip xsltproc zathura -y;

# The following need to be installed manually as the Debian / Ubuntu archives are too old...
# 1. nnn - Note: only installing Ubuntu 18.04 right now
curl -s https://api.github.com/repos/jarun/nnn/releases/latest | jq -r ".assets[] | select(.name | test(\"ubuntu18\")) | .browser_download_url" | wget -qi - ;
sudo dpkg -i nnn*.deb;
rm nnn*.deb; 
# youtube-dl - Note: this may be already installed under Pop!OS.
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl;
sudo chmod a+rx /usr/local/bin/youtube-dl;


###############################################################################
# Terminal / Commandline configuration
###############################################################################
# Fonts - do first as the st-terminal requires it on compile
git clone https://github.com/ryanoasis/nerd-fonts.git .fonts --depth=1;
cd .fonts; 
./install.sh FiraMono;
cd ~;
# suckless tools
mkdir $HOME/.my-settings/build-area;
# suckless st
git clone https://github.com/avastmick/st.git $HOME/.my-settings/build-area/st-term;
cd $HOME/.my-settings/build-area/st-term && sudo make install;
git remote git remote add upstream https://git.suckless.org/st;
# suckless surf - TODO this does not compile at this point
# sudo apt install webkit2gtk-4.0 gtk-3.0
# git clone https://github.com/avastmick/surf.git $HOME/.my-settings/build-area/surf-browser;
# cd $HOME/.my-settings/build-area/surf-browser && sudo make install;
# git remote git remote add upstream https://git.suckless.org/surf;
# Return to ~
cd $HOME;
# Add in a prompt to show git status etc.
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# Configure git to print pretty git log trees
git config --global alias.lg "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

# Add in tmux session management - https://github.com/jamesottaway/tmux-up
sudo curl -L https://git.io/tmux-up -o /usr/local/bin/tmux-up;
sudo chmod u+x /usr/local/bin/tmux-up;

###############################################################################
# Editor - Vim (NeoVim), of course
###############################################################################
# Python pip and the Neovim package
python3 -m pip install --upgrade pip;
python3 -m pip install neovim;
# Install spacevim
curl -sLf https://spacevim.org/install.sh | bash -s -- --install neovim;

###############################################################################
# Coding environment - various languages.
#   - Right now:
#     - Rust
#     - JavaScript
###############################################################################

# Install Rust via rustup.rs
curl https://sh.rustup.rs -sSf | sh -s -- -y;
source $HOME/.cargo/env;
rustup completions bash >> $HOME/.bash_completion;
rustup install nightly beta; 
rustup component add rustfmt-preview rls-preview rust-analysis clippy-preview rust-src;
# Install WASM targets
rustup target add wasm32-unknown-unknown asmjs-unknown-emscripten wasm32-unknown-emscripten;
# Install sccache for caching.
cargo install sccache;
# ctag handler for rls
cargo install rusty-tags;
# racer
cargo +nightly install racer;
# Security audit - check for vulns
cargo install cargo-audit;
# Cargo tree cargo crate deps visualizer
cargo install cargo-tree;
# cargo-watch (https://github.com/passcod/cargo-watch) a daemon that checks for changes
cargo install cargo-watch;
# Install the Rust web frontend tool
cargo install cargo-web;
# cargo generate - for creating a project with a specified template
cargo install cargo-generate;
# add diesel cli tools - REQUIRES A DATABASE TO BE INSTALLED
# e.g. PostgreSQL:
sudo apt install postgresql postgresql-contrib postgresql-client libpq-dev;
cargo install diesel_cli --no-default-features --features postgres;
# Debugging - LLDB
sudo apt install lldb-6.0 rust-lldb python-lldb-6.0 liblldb-6.0;

# WASM - wasm-pack
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh;

# WASM - emscripten sdk - OFF for now
# curl https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz | tar -zxv -C ~/;
# cd ~/emsdk-portable;
# ./emsdk update;
# ./emsdk install sdk-incoming-64bit;
# ./emsdk activate sdk-incoming-64bit;

# ASDF (languages package manager)
git clone --branch v0.5.1 https://github.com/asdf-vm/asdf.git ~/.asdf;
. $HOME/.asdf/asdf.sh
# Node JS (stable)
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
asdf install nodejs 10.14.1;
asdf global nodejs 10.14.1;

# Java SDK - needed for the emscripten sdk
asdf plugin-add java;
asdf install java openjdk-11.0.1;
asdf global java openjdk-11.0.1;

# Yarn (better npm)
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -;
sudo sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list';
sudo apt update && sudo apt install yarn -y;

# Install the JavaScript/Typescript langserver
npm install -g javascript-typescript-langserver;

###############################################################################
# Infrastructure Tools
###############################################################################

# Docker
sh -c "$(curl -fsSL https://get.docker.com/)";
sudo usermod -aG docker avastmick;

# Terraform
wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip;
unzip terraform_0.11.10_linux_amd64.zip;
sudo install terraform /usr/local/bin/;
rm terraform_0.11.10_linux_amd64.zip;
# Keybase
curl -O https://prerelease.keybase.io/keybase_amd64.deb;
sudo dpkg -i keybase_amd64.deb && sudo apt-get install -f && rm keybase_amd64.deb && run_keybase;
# Krypt.co kr
sh -c "$(curl -fsSL  https://krypt.co/kr/)";

###############################################################################
# Install settings - profile Vim.init etc.
###############################################################################
~/.my-settings/install-settings.sh;
# Terminal setup - colours!
wget -O xt https://git.io/v7eBS && chmod +x xt && ./xt && rm xt;

###############################################################################
## Need to do some rather heavy config to allow mpd etc work
###############################################################################
sudo systemctl disable mpd;
systemctl --user enable mpd;

###############################################################################
## Okay should be done - all you need to do is reload your ~/.bashrc
###############################################################################
. ~/.bashrc;
echo "Should be done. Probably worth logging out and in again."
