#!/bin/bash

###############################################################################
# Install script for VPN services on Ubuntu
###############################################################################

# Wireguard
sudo add-apt-repository ppa:wireguard/wireguard;

# Shadowsocks
echo "deb https://repo.debiancn.org/ testing main" | sudo tee /etc/apt/sources.list.d/debiancn.list;
wget https://repo.debiancn.org/pool/main/d/debiancn-keyring/debiancn-keyring_0~20161212_all.deb -O /tmp/debiancn-keyring.deb;
sudo apt install /tmp/debiancn-keyring.deb;
rm /tmp/debiancn-keyring.deb;

sudo apt update && sudo apt install wireguard shadowsocks-qt5   
