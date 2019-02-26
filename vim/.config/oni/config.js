const activate = (oni) => {
    oni.input.unbind("<c-g>") // make C-g work as expected in vim
    oni.input.bind("<s-c-g>", () => oni.commands.executeCommand("sneak.show")) // You can rebind Oni's behaviour to a new keybinding
};

module.exports = {
    activate,
    "tabs.mode": "native",
    "ui.colorscheme": "gruvbox",
    "oni.hideMenu": true, // Hide default menu, can be opened with <alt>
    "sidebar.enabled": false,
    "statusbar.enabled": false,
    "editor.scrollBar.visible": false,
    "editor.fullScreenOnStart": true,
    "oni.useDefaultConfig": false, // Do not load Oni's init.vim
    "oni.loadInitVim": true, // Load user's init.vim
    "autoClosingPairs.enabled": false, // disable autoclosing pairs
    "editor.quickOpen.filterStrategy": "regex", // A strategy for the fuzzy finder closer to CtrlP
    'commandline.mode': false, // Do not override commandline UI
    'wildmenu.mode': false, // Do not override wildmenu UI,
    "learning.enabled": false, // Turn off learning pane
    "achievements.enabled": false, // Turn off achievements tracking / UX
    "editor.fontFamily": "Fira Mono",
    "editor.fontSize": "18px",
}
