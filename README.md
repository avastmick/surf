# My dotfiles

These scripts and notes in this repository are how I set up my development machine the way I like them.

Feel free to use, comment or offer alternatives.

Current examples:

- [Arch Linux](./Arch-Install.md)
- [Ubuntu](./Ubuntu-Install.md)

## General Linux

### Firefox

Firefox is my favourite as Mozilla is likely less evil than Google. The Quantum engine is just as fast and I see no loss of performance overall, nor miss any specific add-ons etc. The privacy settings are _much_ better in my opinion. If nothing else, I like the idea of supporting an alternative, if not Firefox the world is locked into a Google browser future.

#### HiDpi

On 4K screens the fonts etc are too small for me. In `about:config` set `layout.css.devPixelsPerPx` to "2.5"

### DNS

Mozilla has made the decision to route DNS requests through Cloudflare. This can be disabled in `about:config`, setting `network.trr.mode` to "5". I find that connections are established quicker with this setting.
