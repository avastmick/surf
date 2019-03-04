# Arch Linux Installation Notes

The following uses [Anarchy](https://anarchy-linux.org/) without a desktop and manually install from the terminal.

## Anarchy Configuration

- Defaults:
- English
- Begin install process? -> Yes
- Download and rank mirrors -> Yes -> Defaults
- US keymap and keyboard
- Timezone -> choose
- __Auto partition encrypted LVM__ -> `<Ok>`
- `sda` -> `ext4` -> `<Ok>` - see Backup and snapshots
- Swap matches RAM size
- GPT Partitioning -> `<Yes>`
- `<Write-Changes>` and enter LUKS password
- `Anarchy Advanced install options`
- `Arch-Linux-Hardened-Deve` - hardened kernel with tools installed.
- `zsh` shell
- `None` - Clean ZSH install no RC
- `syslinux`
- `networkmanager`
- Defaults
- Add wifi - `<Yes>`
- No to PPPoE
- Yes to os-prober
- No to desktop - will do that manually
- Provide hostname
- Set __strong__ root password
- `<New User>` add yourself
- Enable administrative privilege for <user> - `<Yes>`
- `<Done>`
- Skip adding software, it's easier when cut and paste is available.
- `<Install>`
- Reboot

## After start-up (terminal only)

### System configuration

#### Backup and snapshots

Ideally, given the risk of messing up a system configuration while installing software etc. for development, it would be a good idea to have some form of incremental back or snapshots.

There are a [number of solutions](https://wiki.archlinux.org/index.php/System_backup). The most promising seems to be the package Snapper, but the initial system install is fairly involved and seems to require a raw install of `Arch` without the help of `Anarchy's` installer in order to configure the `btrfs` layout correctly. Also there may be issues with `Docker`, I need to look into this further before committing as I am a heavy user of `Docker`. So for now, the `btrfs/snapper` solution is parked.

Right now, I don't have a solution I really like. So I'll work on this whole install solution to make it quicker and make sure user data is backed up elsewhere.

### Desktop install

Reboot into commandline. Make sure you remove the Live USB

- `sudo pacman -Sy gnome`
- Accept all the defaults there is little bloat.

Enable Gnome desktop

- `sudo systemctl enable --now gdm.service`

Reboot into desktop

## Configure Desktop

- Install the `developer-machine` repo so the commands can be more easily copied during installation:
  - `sudo pacman -S git && git clone https://github.com/avastmick/developer-machine ~/.my-settings`

### Install base software:

First install a browser, my go to is Firefox, the latest versions are as good as anything else out there, I find.

- `sudo pacman -S firefox`

Now you can open up this file in a browser to cut and pasting commands!

- `firefox ~/.my-settings/Arch-Install.html &`

Now install the basics:

- `sudo pacman -S neovim ctags openssh gparted ntfs-3g p7zip ufw wget chromium vlc virtualbox`

I suggest logging out and in again

Install [trizen - an AUR helper](https://github.com/trizen/trizen)

```bash
mkdir -p ~/Downloads/builds && \
cd ~/Downloads/builds && \
git clone https://aur.archlinux.org/trizen.git && \
cd trizen && makepkg -si
```

Now you should be able to install the same packages as you would on Ubuntu using trizen

- Example: `trizen -S [name_of_package]` - easy!

### Making the desktop pretty

- Install Gnome Tweaks
  - `sudo pacman -S gnome-tweak-tool`

### Install Gnome Extensions, Themes and Icons

```bash
trizen -S gnome-shell-extension-extended-gestures-git \
           gnome-shell-extension-dash-to-dock \
           pop-gtk-theme-bin \
           pop-icon-theme-git
```

Manually install [gnome-shell-extension hide-top-bar](https://extensions.gnome.org/extension/545/hide-top-bar/), for more screen real estate

### Install fonts

```bash
sudo pacman -S adobe-source-han-sans-cn-fonts adobe-source-han-sans-jp-fonts \
    adobe-source-han-sans-kr-fonts adobe-source-code-pro-fonts \
    noto-fonts-emoji powerline powerline-fonts

trizen -S nerd-fonts-complete nerd-fonts-complete-mono-glyphs \
          ttf-fira-sans ttf-fira-mono \
          otf-fira-code \
          ttf-roboto ttf-roboto-slab \
          otf-font-awesome-4
```

- Open Tweak tool:
  - Extensions toggle on "User themes", and all those installed above and configure.
  - Log in and out again
  - Appearance -> Global Dark Theme [ ] (uncheck)
  - Appearance -> Themes -> Set all to "Pop"
  - Fonts:
   - Window Title -> `Fira Sans SemiBold`
   - Interface -> Fira Sans Book
   - Document -> Roboto Slab Regular
   - Monospace -> Fira Mono Regular

### Development Tools

- Install `tilix` a nice terminal emulator
  - `sudo pacman -S tilix dconf`
  - Preferences `Default -> Command -> "Run command as login shell" is checked [x]`
  - Configure keyboard shortcut `tilix` ["Quake mode"](https://github.com/gnunn1/tilix/wiki/Quake-Mode) - oh, so useful!
    - __NOTE:__ Currently (March 2018) broken for `Wayland` use, so need to run `tilix` under `X11`
    - Shortcut: `<F10>`
    - Command: `env GDK_BACKEND=x11 tilix --profile=quake`
  - Back-up using:
    - `dconf dump /com/gexperts/Tilix/ > tilix.dconf`
  - Import using:
    - `dconf load /com/gexperts/Tilix/ < tilix.dconf`
- Add themes:
  - `mkdir -p ~/.config/tilix/schemes/`
  - `wget -qO $HOME"/.config/tilix/schemes/gruvbox.json" https://git.io/v7Qas`
  - Apply in tilix -> `Preferences/Default/Color/Color scheme`
  - Change the default terminal application:
    - `gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/tilix && \
       gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"`

- Using `tilix` for `vim` seems buggier than using `gnome-terminal`, so:
- Set the `gnome-terminal` to look the same - this is for `neovim` to look nice
  - `wget -O xt https://git.io/v7eBS && chmod +x xt && ./xt && rm xt`
  - Preferences `General` uncheck `Show menubar by default` and `Enable menu accelerator`
  - Preferences `Default -> Text -> Custom font [x] -> Fira Mono Regular 14`
  - Preferences `Default -> [dropdown] -> Clone name "Vim"`
  - Preferences `Vim -> Text -> set terminal size 154 columns x 36 rows`
  - Preferences `Vim -> Scrolling` uncheck `Show scrollbar`
  - Create keyboard shortcut:
    - Name: "Vim"
    - Command: `gnome-terminal --window-with-profile=Vim -- nvim`
    - Shortcut: `Ctrl` + `Alt` + `V`

#### OhMyZsh and NeoVim configuration

- Install [oh-my-zsh](http://ohmyz.sh/)
  - `sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
- Configure profile
  - `cp ~/.my-settings/profile/.zshrc ~/.zshrc`
  - `cp ~/.my-settings/profile/.profile ~/.profile`
- Configure NeoVim
  - `curl -sLf https://spacevim.org/install.sh | bash -s -- --install neovim`
  - Run `nvim` accept defaults - need to test whether this is actually needed...
  - `cp ~/.my-settings/vim/.SpaceVim.d/init.vim ~/.SpaceVim.d/`
- Re-start terminal

### Code and Languages - do this first __before__ starting `nvim`!

- [asdf](https://github.com/asdf-vm/asdf)
    - `git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.2`
      - `echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc`
      - `echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc`
- Go (untested)
  - `asdf plugin-add golang && asdf install golang 1.10 && asdf global golang 1.10`
- Java (not with `asdf` as it doesn't propagate `PATH` properly)
  - `sudo pacman -S jdk10-openjdk jdk9-openjdk jdk8-openjdk`
  - `archlinux-java set java-9-openjdk` 
  - `asdf plugin-add gradle && asdf install gradle 4.6 && asdf global gradle 4.6`
  - `asdf plugin-add maven && asdf install maven 3.5.3 && asdf global maven 3.5.3`
  - `trizen -S sbt-latest`
  - `sudo pacman -S uncrustify`
- Rust (not with `asdf` as it makes it more complicated than with rustup)
  - `sh -c "$(curl -fsSL https://sh.rustup.rs -sSf)"`
      - `mkdir ~/.zfunc && rustup completions zsh > ~/.zfunc/_rustup`
  - `rustup install nightly beta`
  - `rustup component add fmt-preview rls-preview rust-analysis rust-src`
  - `cargo install racer && cargo +nightly install clippy`
- Python (not with `asdf` as it breaks stuff!)
  - `sudo pacman -S python-pip`
  - `sudo pip install --user py flake8 yapf autoflake isort jedi tox neovim`
- Javascript
  - `asdf plugin-add nodejs && asdf install nodejs 10.0.0 && node global nodejs 10.0.0`
  - `sudo pip install jsbeautifier`
- Docker
  - `sudo pacman -S docker`
  - `sudo usermod -aG docker $USER`
  - `sudo systemctl start docker`
  - `sudo systemctl enable docker`

- Android - not yet tested fully
  - `trizen -S android-platform android-sdk android-sdk-platform-tools android-sdk-build-tools`
  - `sudo groupadd sdkusers && sudo gpasswd -a avastmick sdkusers && sudo chown -R :sdkusers \
    /opt/android-sdk/ && sudo chmod -R g+w /opt/android-sdk/ && newgrp sdkusers`

### Rust and checking NeoVim

First, logout and in again to ensure all path items are propagated ok.

Hit `Ctrl` + `Alt` + `V`, or open the `NeoVim` app (it's just a terminal wrapper). Should all load up. Check on a file to see auto-complete functioning.

### Making Boot pretty

I know, people say, why bother, but the startup of the machine adds to gloss, so I like that it looks good.

TODO: Tried `plymouth`, but the boot was too slow and the encrypt entry super laggy.

Do need to make the console font readable though:

```bash
sudo vi /etc/vconsole.conf
KEYMAP=us
FONT=sun12x22
:wq

sudo mkinitcpio -p linux
```

### System tools

- VNC client
  - `sudo pacman -S remmina libvncserver avahi-daemon nss-mdns`
  - Configure bonjour/zeroconf: `sudo vim /etc/nsswitch.conf` add `mdns4` to end of `hosts` line
- Power tools
  - `sudo pacman -S tlp ethtool smartmontools x86_energy_perf_policy tlp-rdw powertop`
  - Tune:
      - `sudo systemctl enable tlp.service`
      - `sudo systemctl enable tlp-sleep.service`
      - `sudo systemctl enable NetworkManager-dispatcher.service`
      - `sudo systemctl mask systemd-rfkill.service`
      - `sudo systemctl mask systemd-rfkill.socket`

### System Tuning

#### Ensure Wayland on dual GPU systems (laptops)

- Add `MUTTER_ALLOW_HYBRID_GPUS=1` to your /etc/environment
- Set `WaylandEnable=true` in /etc/gdm/custom.conf

Or, install gestures for running under x11:

- `trizen -S libinput-gestures`

#### Optimise the kernal for desktop usage

```bash
sudo tee -a /etc/sysctl.d/99-sysctl.conf <<-EOF
vm.swappiness=1
vm.vfs_cache_pressure=50
vm.dirty_background_bytes=16777216
vm.dirty_bytes=50331648
EOF
```

#### Setup graphics drivers

I don't use the discrete card on my machine (Dell XPS 15 9550)
- `sudo pacman -Sy xf86-video-intel`
- `sudo vi /etc/modprobe.d/nouveau.conf`
  - Add:
  - `blacklist nouveau
  -  blacklist nvidia`

Reboot and check

### Other tools and apps

  - `trizen -S megasync` - my best worst cloud provide regarding cost vs privacy vs security
  - `trizen -S keybase-bin` - getting more useful all the time
  - `trizen -S kr` - keeps my private keys off my laptop, I know questionable, but usable and easier to setup than yubikey for this purpose
  - `trizen -S signal` - my favourite messenging app on the desktop
  - `trizen -S mailspring` - the only pretty email client on linux, I hate the look and function of Thunderbird
  - `trizen -S snapd` - snaps are useful and make install complex apps a breeze with no deps pain, keep cruft levels lower
  - `trizen -S onedrive` - makes accessing work documents etc easier
  - `trizen -S fontawesome.sty` - requires fontawesome 4 installed, see Fonts (above)

