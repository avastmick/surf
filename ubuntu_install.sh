#!/bin/bash
###############################################################################
# Install script for Ubuntu
###############################################################################

# Bootstrap install:
# git clone https://github.com/avastmick/developer-machine.git .my-settings

###############################################################################
# PPA and external sources
###############################################################################
# Signal
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list;
# Etcher
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 379CE192D401AB61 && sudo sh -c "echo 'deb https://dl.bintray.com/resin-io/debian stable etcher' > /etc/apt/sources.list.d/resin-io-etcher.list";
# Wireguard
sudo add-apt-repository ppa:wireguard/wireguard;
# Shadowsocks (doesn't work)
# echo "deb https://repo.debiancn.org/ testing main" | sudo tee /etc/apt/sources.list.d/debiancn.list;
# wget https://repo.debiancn.org/pool/main/d/debiancn-keyring/debiancn-keyring_0~20161212_all.deb -O /tmp/debiancn-keyring.deb;
# sudo apt install /tmp/debiancn-keyring.deb;
# rm /tmp/debiancn-keyring.deb;
# Vivaldi
echo "echo deb http://repo.vivaldi.com/stable/deb/ stable main > /etc/apt/sources.list.d/vivaldi.list" | sudo sh;
curl http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1397BC53640DB551;
# Ansible
sudo apt-add-repository --yes --update ppa:ansible/ansible;
# Install NeoVim from ppa as the Debian repo is very old
sudo add-apt-repository ppa:neovim-ppa/stable;
###############################################################################
# Start the package installs
###############################################################################
# Update
sudo apt update && sudo apt upgrade -y;

# Install stuff
sudo apt install ansible ccache chromium-browser cmake colordiff deluge etcher-electron evolution-ews exuberant-ctags flatpak gnome-software-plugin-flatpak libssl-dev neovim nnn p7zip-full pandoc pass php powertop python-pip python-pip3 qemu-user-static signal-desktop texlive texlive-fonts-extra texlive-xetex tlp tlp-rdw tmux uget virtualbox virtualbox-ext-pack vivaldi-stable wdiff wireguard xclip xsltproc zsh -y;

###############################################################################
# Terminal / Commandline configuration
###############################################################################
# Install ohmyzsh!
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)";
# Install theme
git clone https://github.com/avastmick/spaceship-zsh-theme.git "$ZSH_CUSTOM/themes/spaceship-prompt";
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme";
# Fonts
git clone https://github.com/ryanoasis/nerd-fonts.git .fonts --depth=1;
cd .fonts; 
./install.sh FiraMono;
cd ~;
# There is an issue here that the gnone-terminal filters on mono-spaced fonts
#   and the nerd font is not shown... do this via the dconf import

###############################################################################
# Editor - Vim (NeoVim), of course
###############################################################################
# Python pip and the Neovim package
python -m pip install --upgrade pip;
python3 -m pip install --upgrade pip;
python -m pip install neovim;
python3 -m pip install neovim;
# Install spacevim
curl -sLf https://spacevim.org/install.sh | bash -s -- --install neovim;

###############################################################################
# Coding environment - various languages.
#   - Right now:
#     - Rust
#     - JavaScript
###############################################################################

sudo snap install universal-ctags;

# Install Rust via rustup.rs
curl https://sh.rustup.rs -sSf | sh -s -- -y;
source $HOME/.cargo/env;
mkdir ~/.zfunc && rustup completions zsh > ~/.zfunc/_rustup;
rustup install nightly beta; 
rustup component add rustfmt-preview rls-preview rust-analysis clippy-preview rust-src;
rustup target add wasm32-unknown-unknown asmjs-unknown-emscripten;
# Install sccache for caching.
cargo install sccache;
# ctag handler for rls
cargo install rusty-tags;
# racer
cargo +nightly install racer;
# Security audit - check for vulns
cargo install cargo-audit;
# cargo-watch (https://github.com/passcod/cargo-watch) a daemon that checks for changes
cargo install cargo-watch;
# Install the Rust web frontend tool
cargo install cargo-web;
# add diesel cli tools - REQUIRES A DATABASE TO BE INSTALLED
# e.g. PostgreSQL:
sudo apt install postgresql postgresql-contrib postgresql-client libpq-dev;
cargo install diesel_cli --no-default-features --features postgres;
# Debugging - LLDB
sudo apt install lldb-6.0 rust-lldb python-lldb-6.0 liblldb-6.0;

# ASDF (languages package manager)
git clone --branch v0.5.1 https://github.com/asdf-vm/asdf.git ~/.asdf;
# Node JS (stable)
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
# asdf install nodejs 10.14.1;
# asdf global nodejs 10.14.1;

# Yarn (better npm)
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -;
sudo sh -c 'echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list';
sudo apt update && sudo apt install yarn -y;

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
# Draw.io
curl -O https://github.com/jgraph/drawio-desktop/releases/download/v9.3.1/draw.io-amd64-9.3.1.deb;
sudo dpkg -i draw.io-amd64-9.3.1.deb && rm draw.io-amd64-9.3.1.deb;

###############################################################################
# Install settings - profile Vim.init etc.
###############################################################################
~/.my-settings/install-settings.sh;
# Terminal setup - colours!
wget -O xt https://git.io/v7eBS && chmod +x xt && ./xt && rm xt;
###############################################################################
## Okay should be done - all you need to do is change the shell to zsh!
###############################################################################
echo "Now change your shell to zsh, and then logout and in again for the config to be loaded.";
chsh -s /bin/zsh;
