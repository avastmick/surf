""==============================================================================
"" Personal `Vim` custom configuration
"" Name: Mick Clarke (avastmick)
"" Date: February 2019
""==============================================================================
"" this is run BEFORE the layers loading of spacevim
function! myspacevim#before() abort
  " Set the terminal title
  set title
  set titleold="Terminal"
  set titlestring=%F

  " Set the mouse to be only in normal mode!
  set mouse=n
  " Set soft wrap
  set wrap
  "" Copy/Paste/Cut
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
  endif

  " Transparent editing
  let g:seiya_auto_enable=1
  " Default value: ['ctermbg']
  let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

  " Startify settings
  let g:startify_custom_header = []
  let g:startify_lists = [
  \ { 'type': 'files',     'header': [ 'Files' ]     },
  \ { 'type': 'sessions',  'header': [ 'Sessions' ]  },
  \ { 'type': 'bookmarks', 'header': [ 'Bookmarks' ] },
  \ { 'type': 'commands',  'header': [ 'Commands' ]  },
  \ ]

  " Set <Alt> mappings for INSERT mode.
  "  Lots of Neovim incompatability issues
  set winaltkeys=no
  let s:printable_ascii = map(range(char2nr('a'), char2nr('z')), 'nr2char(v:val)')
  for s:char in s:printable_ascii
    execute "imap <A-" . s:char . "> <Esc>" . s:char
    execute "nmap <A-" . s:char . "> <Esc>" . s:char
  endfor
  unlet s:printable_ascii s:char

endfunction

"" This is run AFTER the layers loading of SpaceVim
function! myspacevim#after() abort

  " Toggle Zen mode with goyo
  let g:goyo_width = 120
  let g:goyo_height = 100
  nnoremap [SPC]zz :Goyo<CR>

  " Spell checking
  " nnoremap [SPC]sp :setlocal spell! spelllang=en_gb<CR>

  " Set <Esc> key to :noh to cancel search highlighting
  nnoremap <Esc> :noh<CR><Esc>

  " Configure vimfiler
  nnoremap [SPC]<F3> :VimFilerBufferDir<CR>
  let g:vimfiler_enable_auto_cd=1

  " folding config {{{
  au FileType rust set foldmethod=syntax
  au FileType go set foldmethod=syntax
  au FileType java set foldmethod=syntax
  au FileType javascript set foldmethod=syntax
  au FileType python set foldmethod=indent
  " }}}

  " session config
  nnoremap [SPC]so :SLoad<Space>
  nnoremap [SPC]sv :SSave<Space>
  nnoremap [SPC]sd :SDelete<CR>
  nnoremap [SPC]sq :SClose<CR>
  " }}}

  " Setup a "TODO" lookup handler
  noremap [SPC]td :noautocmd vimgrep /TODO/j **/*<CR>:cw<CR>
  " Setup a "FIXME" lookup handler
  noremap [SPC]fm :noautocmd vimgrep /FIXME/j **/*<CR>:cw<CR>
  " Sort words alphabetically on a line
  noremap [SPC]sal :call setline('.', join(sort(split(getline('.'), ' ')), " "))<CR>

  " Rust Settings: {{{
    "   TODO:
    "   What I want to do:
    "   - have the same experience as in VSCode
    "   - Not have duplications or spotty autocompletes that lead to overwork
    set hidden
    let g:racer_experimental_completer = 0
    let g:rustfmt_autosave = 1
    " keymapping definitions
    au FileType rust nmap gd <Plug>(rust-def)
    au FileType rust nmap gs <Plug>(rust-def-split)
    au FileType rust nmap gx <Plug>(rust-def-vertical)
    au FileType rust nmap <leader>gd <Plug>(rust-doc)
    " RLS config
    if executable('rls')
      au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
    endif
    let g:asyncomplete_remove_duplicates = 1
    " The following don't appear to function, though LSP errors do appear
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_signs_enabled = 0
    let g:lsp_signs_error = {'text': '✗'}
  " }}}
 
  " Markdown Settings: {{{
    " TODO the following doesn't work and opens (always) in Firefox
    let g:mkdp_browser = '/usr/bin/surf'
  " }}}

endfunction
