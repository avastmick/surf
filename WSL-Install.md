# Windows Subsystem for Linux installation notes

## Windows additions

Most stuff "Just works" within the WSL environment, so much of the installation script and config can be re-used from the Ubuntu install script, with modifications.

The following is needed on the "host" however.

### Terminal Emulator

[WSLtty](https://github.com/mintty/wsltty), using the Powerline font (see below) and in 256color mode

### Fonts

Install suitable fonts that support Powerline:

- [Fura code Nerd font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/complete/Fura%20Mono%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.otf)

## Issues

Currently, `tmux` and `vim` load, but do not work exactly as per the Linux install (i.e. not on Windows). The shortcut keys are not working for:

### In plain Vim mode:

This is _not_ the case in `nvim` and an `alias` `vim` -> `nvim` fixes these

- `F2` and `F3` in `vim` - toggle tags and `vimfiler`, however these keys _DO_ work in `tmux` (toggle on/off the status bar `Ctl-F3`)
- `vim` always starts in `INSERT` mode and in the last file edited.
- `vimproc` warning. Not sure on this right now as it maybe a false environment flag - it disappears after my configuration is loaded.

### General

- Everything is a lot slower to load and shortcuts are not immediate
