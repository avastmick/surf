#!/bin/bash

# Restore `.bashrc`
cp $HOME/.my-settings/profile/.bashrc $HOME/.bashrc
cp $HOME/.my-settings/profile/.bash_aliases $HOME/.bash_aliases

# Add the Vim init.vim to Spacevim
# A hacky fix - sometime the SpaceVim install doesn't create a config dir, but leaves a file.
if [ -d  $HOME/.SpaceVim.d ]; then
    # the directory exists and the SpaceVim install created a directory
    if [ -f $HOME/.SpaceVim.d/init.toml ]; then
      echo "Removing init.toml";
      rm $HOME/.SpaceVim.d/init.toml;
    fi
    cp -R $HOME/.my-settings/vim/.SpaceVim.d/. $HOME/.SpaceVim.d/.;
    echo "Copied new Vim config";
else
  if [ -f  $HOME/.SpaceVim.d ]; then
    rm $HOME/.SpaceVim.d;
  else 
    mkdir $HOME/.SpaceVim.d;
    cp -R $HOME/.my-settings/vim/.SpaceVim.d/. $HOME/.SpaceVim.d/.;
    echo "Copied init.vim";
  fi
fi

# Copy over .tmux.conf
cp $HOME/.my-settings/tmux/.tmux.conf $HOME/.tmux.conf
cp $HOME/.my-settings/tmux/std.conf $HOME/.tmux/std.conf

# Copy over .vifm settings
mkdir $HOME/.vifm;
cp -R $HOME/.my-settings/vifm/. $HOME/.vifm/.

# Restore music player settings
mkdir $HOME/.config/mpd
cp $HOME/.my-settings/music/mpd/mpd.conf $HOME/.config/.
mkdir $HOME/.ncmpcpp
cp $HOME/.my-settings/music/ncmpcpp/conf $HOME/.ncmpcpp/.

# Restore terminal settings
# dconf load /com/gexperts/Tilix/ < $HOME/.my-settings/terminal/tilix.dconf
dconf load /org/gnome/terminal/ < $HOME/.my-settings/terminal/gnome-terminal.dconf
# TODO load the keyboard shortcuts for tmux, vim and mpc
# ...

