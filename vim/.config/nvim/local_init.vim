" Set the initial terminal size for the editor
set lines=40 columns=160

" Set NERDTree width - default is way to large
let g:NERDTreeWinSize = 25

" Set pretty NERDTree git indicators
" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "\u0x6C",
"     \ "Staged"    : "+",
"     \ "Untracked" : "\u273C",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ 'Ignored'   : '☒',
"     \ "Unknown"   : "?"
"     \ }

" Folding config
filetype plugin indent on
syntax on
let anyfold_activate=1
set foldlevel=1

" Mappings
" Set the <ESC> key for :terminal
tnoremap <Esc> <C-\><C-n>?\$<CR>
nnoremap <esc> :noh<return><esc>

" shortcut to remove trailing whitespace
noremap <Leader>sp :%s/\s\+$//e

" Let the clipboard capture system
set clipboard=unnamedplus

" Set the colorscheme
if !exists('g:not_finish_vimplug')
  colorscheme onedark
endif
let g:airline_theme='onedark'

" powerline fonts
let g:airline_powerline_fonts = 1

" rust
let g:deoplete#enable_at_startup = 1
" Vim racer
let g:racer_cmd = "/home/avastmick/.cargo/bin/racer"
let $RUST_SRC_PATH='/home/avastmick/.rust/src/'
let g:racer_experimental_completer = 1

" Set the markdown composer to _NOT_ open at start
let g:markdown_composer_open_browser = 0

