#!/bin/bash
###############################################################################
# Install script for terminal-based Signal messenger
###############################################################################

# Uses the following:
#   - https://github.com/isamert/scli
#   - https://github.com/AsamK/signal-cli
#   - qrencode
#   - libunixsocket-java
#   - urwid

# Check prerequisites, install if missing
# Install deps
sudo apt install libunixsocket-java libmatthew-debug-java libnotify-bin notify-osd qrencode;
pip3 install urwid;
command -v signal-cli >/dev/null && { echo "signal-cli installed"; } || { echo "signal-cli not found, installing."; 
  # Install the Signal CLI - latest version found at: https://github.com/AsamK/signal-cli/releases
  CLI_VERSION=0.6.2;
  wget https://github.com/AsamK/signal-cli/releases/download/v"${CLI_VERSION}"/signal-cli-"${CLI_VERSION}".tar.gz;
  sudo tar xf signal-cli-"${CLI_VERSION}".tar.gz -C /opt;
  sudo ln -sf /opt/signal-cli-"${CLI_VERSION}"/bin/signal-cli /usr/local/bin/;
}
command -v scli >/dev/null && { echo "scli installed"; } || { echo "scli not found, installing.";
  git clone https://github.com/isamert/scli.git;
  sudo cp scli/scli /opt/.;
  sudo ln -sf /opt/scli /usr/local/bin/;
}
echo "All set. Now configure according to the instructions";

surf https://github.com/isamert/scli;
