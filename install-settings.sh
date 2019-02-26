#!/bin/bash

# Restore `.zshrc`
cp ~/.my-settings/profile/.zshrc $HOME/.zshrc

# Add the Vim init.vim to Spacevim
# A hacky fix - sometime the SpaceVim install doesn't create a config dir, but leaves a file.
if [ -d  $HOME/.SpaceVim.d ]; then
    # the directory exists and the SpaceVim install created a directory
    if [ -f $HOME/.SpaceVim.d/init.toml ]; then
      echo "Removing init.toml";
      rm $HOME/.SpaceVim.d/init.toml;
    fi
    cp -R ~/.my-settings/vim/.SpaceVim.d/. $HOME/.SpaceVim.d/.;
    echo "Copied new Vim config";
else
  if [ -f  $HOME/.SpaceVim.d ]; then
    rm $HOME/.SpaceVim.d;
  else 
    mkdir $HOME/.SpaceVim.d;
    cp -R ~/.my-settings/vim/.SpaceVim.d/. $HOME/.SpaceVim.d/.;
    echo "Copied init.vim";
  fi
fi

# Copy over .tmux.conf
cp ~/.my-settings/tmux/.tmux.conf ~/.tmux.conf

# Restore terminal settings
# dconf load /com/gexperts/Tilix/ < ~/.my-settings/terminal/tilix.dconf
dconf load /org/gnome/terminal/ < ~/.my-settings/terminal/gnome-terminal.dconf

