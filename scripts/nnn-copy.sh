#!/bin/bash
###############################################################################
# Generates a copy command for nnn
###############################################################################

# Linux
cat ~/.nnncp | xargs -0 | xclip -sel clip

# macOS
# cat ~/.nnncp | xargs -0 | pbcopy
