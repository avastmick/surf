# Ubuntu Installation Notes

If you're into Ubuntu, the very best distro is Pop!OS - slick boot, great power management, just damn great!

**TL;DR:** Just run `./Install-Ubuntu.sh`, job done.

## Extra Packages

The following may be installed afterwards.

- Create keyboard shortcut:
    - Name: "Vim"
    - Command: `gnome-terminal --window-with-profile=Vim -- nvim`
    - Shortcut: `Ctrl` + `Alt` + `V`
    - Name: "Tmux"
    - Command: `gnome-terminal --window-with-profile=tmux --full-screen -- tmux`
    - Shortcut: `Ctrl` + `Alt` + `T`

- Gnome Extensions - [https://extensions.gnome.org/](https://extensions.gnome.org/)
  - gnome-shell-extension-extended-gestures-git
  - gnome-shell-extension-dash-to-dock
  - gnome-shell-extension-hide-top-bar
  - gnome-shell-extension-cpu-power-manager
  - https://extensions.gnome.org/extension/615/appindicator-support/
  - https://extensions.gnome.org/extension/1060/timezone/
- asciicinema
  - `sudo apt-add-repository ppa:zanchey/asciinema -y && sudo apt update && sudo apt install asciinema -y`
  - And asciicast2gif via Docker
  - `Docker pull asciinema/asciicast2gif`
- Pandoc - Updates to the latest version.
  - `curl -s https://api.github.com/repos/jgm/pandoc/releases/latest | jq -r ".assets[] | select(.name | test(\"amd64\")) | .browser_download_url" | wget -qi - && sudo dpkg -i pandoc*.deb && sudo apt install texlive-full`
