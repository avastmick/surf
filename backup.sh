#!/bin/bash

# Backup .zshrc file
cp $HOME/.zshrc profile/.zshrc
# Remove sensitive lines
# ANY line that follows the comment SENSITIVE
sed -i '/SENSITIVE/d' profile/.zshrc

# Backup tmux
cp $HOME/.tmux.conf tmux/.tmux.conf

# Backup vifm conf
cp -r $HOME/.vifm/. vifm/.

# Backup old nvim settings
# cp $HOME/.config/nvim/*.vim ./vim/.config/nvim/
# Back up `spacevim` custom settings
cp -r $HOME/.SpaceVim.d ./vim

# Backup `gnome-terminal` settings
dconf dump /org/gnome/terminal/ > $HOME/.my-settings/terminal/gnome-terminal.dconf
