#!/bin/bash
###############################################################################
# Install script for Arch / Manjaro
#   CURRENT STATE: Working install, with some gaps wrt Ubuntu. TODO AUR
###############################################################################

# Bootstrap install:
# git clone https://github.com/avastmick/dotfiles.git .my-settings

# Install the basics:

sudo pacman -Syu --noconfirm ansible base-devel ccache chromium clang cmake colordiff curl deluge etcher evolution-ews ctags flatpak neovim p7zip pandoc pass php powertop python-pip tlp tlp-rdw tmux virtualbox wdiff wireguard-tools xclip zsh;


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
rustup target add wasm32-unknown-unknown asmjs-unknown-emscripten;
# Install sccache for caching.
cargo install sccache;
cargo +nightly install racer;
# Security audit - check for vulns
cargo install cargo-audit;
# cargo-watch (https://github.com/passcod/cargo-watch) a daemon that checks for changes
cargo install cargo-watch;
# Install the Rust web frontend tool
cargo install cargo-web;

# ASDF (languages package manager)
git clone --branch v0.5.1 https://github.com/asdf-vm/asdf.git ~/.asdf;
# Node JS (stable)
# asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git;
# asdf install nodejs 10.14.1;
# asdf global nodejs 10.14.1;

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
# Krypt.co kr - need to use the AUR
# sh -c "$(curl -fsSL  https://krypt.co/kr/)";

###############################################################################
# Install settings - profile Vim.init etc.
###############################################################################
~/.my-settings/install-settings.sh;
###############################################################################
## Okay should be done - all you need to do is change the shell to zsh!
###############################################################################
echo "Now change your shell to zsh, and then logout and in again for the config to be loaded.";
chsh -s /bin/zsh;
