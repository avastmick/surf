#!/bin/bash
###############################################################################
# Install script for Arch / Manjaro
#   CURRENT STATE: Working install, with some gaps wrt Ubuntu. 
###############################################################################

# Bootstrap install:
# git clone https://github.com/avastmick/dotfiles.git .my-settings

# Install the basics:
sudo pacman -Syu --noconfirm ansible avahi base-devel ccache chromium clang cmake colordiff curl deluge docker etcher ctags flatpak mpc mpd ncmpcpp neovim nnn p7zip pandoc pandoc-citeproc pass php postgresql postgresql-client powertop python-pip remmina snapd terraform texlive-most texlive-fontsextra tlp tlp-rdw tmux vifm virtualbox wdiff wireguard-dkms wireguard-tools xclip yay zathura zsh;

###############################################################################
# Terminal / Commandline configuration
###############################################################################
# Install ohmyzsh!
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh;
# Install theme
git clone https://github.com/avastmick/spaceship-zsh-theme.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt";
ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme";
# Fonts
git clone https://github.com/ryanoasis/nerd-fonts.git .fonts --depth=1;
cd .fonts; 
./install.sh FiraMono;
cd ~;
# There is an issue here that the gnone-terminal filters on mono-spaced fonts
#   and the nerd font is not shown... do this via the dconf import
# Terminal setup - colours!
wget -O xt https://git.io/v7eBS && chmod +x xt && ./xt && rm xt;

###############################################################################
# Editor - Vim (NeoVim), of course
###############################################################################
# Python pip and the Neovim package
sudo pip install --upgrade pip;
sudo pip install --user py flake8 yapf autoflake isort jedi tox neovim;
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
mkdir ~/.zfunc && rustup completions zsh > ~/.zfunc/_rustup;
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
cargo install diesel_cli --no-default-features --features postgres;

# WASM - wasm-pack
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh;

# WASM - emscripten sdk
curl https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz | tar -zxv -C ~/;
cd ~/emsdk-portable;
./emsdk update;
./emsdk install sdk-incoming-64bit;
./emsdk activate sdk-incoming-64bit;

# ASDF (languages package manager)
git clone --branch v0.5.1 https://github.com/asdf-vm/asdf.git ~/.asdf;
# Node JS (stable)
# asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
# asdf install nodejs 10.14.1;
# asdf global nodejs 10.14.1;

###############################################################################
# Infrastructure Tools
###############################################################################

# Docker user to group
sudo usermod -aG docker avastmick;

###############################################################################
# AUR - tools and add-ons - after Rust installation due to deps
#   Note: doing last as this is NOT unattended.
#
# VPN - wireguard plugin for Gnome networkmanager
# Socks5 - Shadowsocks QT5 client
# Krypt.co kr - need to use the AUR
# Signal messenger
# Zoom
###############################################################################
yay -S kr networkmanager-wireguard-git shadowsocks-qt5-git signal zoom;

###############################################################################
# Install settings - profile Vim.init etc.
###############################################################################
~/.my-settings/install-settings.sh;
###############################################################################
## Okay should be done - all you need to do is change the shell to zsh!
###############################################################################
echo "Now change your shell to zsh, and then logout and in again for the config to be loaded.";
chsh -s /bin/zsh;
