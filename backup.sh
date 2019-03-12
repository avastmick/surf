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

# Back up music config
cp $HOME/.config/mpd/mpd.conf $HOME/.my-settings/music/mpd/mpd.conf
cp $HOME/.ncmpcpp/config $HOME/.my-settings/music/ncmpcpp/conf

# Back up taskwarrior
cp $HOME/.taskrc $HOME/.my-settings/taskwarrior/.taskrc

# Back up `spacevim` custom settings
cp -r $HOME/.SpaceVim.d ./vim

# Backup `gnome-terminal` settings - still useful, even though I now use suckless st
dconf dump /org/gnome/terminal/ > $HOME/.my-settings/terminal/gnome-terminal.dconf
# Back up gnome desktop keyboard shortcuts etc.
cp $HOME/.config/dconf/user $HOME/.my-settings/dconf/user
