""==============================================================================
"" Personal `Vim` custom configuration
"" Name: Mick Clarke (avastmick)
"" Date: February 2019
""==============================================================================
function! myspacevim#before() abort

  " Set the terminal title
  set title
  set titleold="Terminal"
  set titlestring=%F

  " Startify settings
  let g:startify_custom_header = []
  let g:startify_lists = [
  \ { 'type': 'files',     'header': [ 'Files' ]     },
  \ { 'type': 'sessions',  'header': [ 'Sessions' ]  },
  \ { 'type': 'bookmarks', 'header': [ 'Bookmarks' ] },
  \ { 'type': 'commands',  'header': [ 'Commands' ]  },
  \ ]

  " Set the mouse to be only in normal mode!
  set mouse=n

  " Set soft wrap
  set wrap

  "" Copy/Paste/Cut
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
  endif

  " No love for <Esc>
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

function! myspacevim#after() abort

  " Set <Esc> key to :noh to cancel search highlighting
  nnoremap <Esc> :noh<CR><Esc>

  " Configure vimfiler
  nnoremap [SPC]<F3> :VimFilerBufferDir<CR>
  " let g:vimfiler_enable_auto_cd=1

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

  " Setup a TODO lookup handler
  noremap [SPC]td :noautocmd vimgrep /TODO/j **/*<CR>:cw<CR>
  " Setup a FIXME lookup handler
  noremap [SPC]fm :noautocmd vimgrep /FIXME/j **/*<CR>:cw<CR>
  " Sort words alphabetically on a line
  noremap [SPC]sal :call setline('.', join(sort(split(getline('.'), ' ')), " "))<CR>

  " Rust Settings: {{{
  let g:rustfmt_autosave = 1
  " vim-racer DISABLED
  " set hidden
  " let g:racer_cmd =expand('$HOME/.cargo/bin/racer')
  let $RUST_SRC_PATH=substitute(system('rustc --print sysroot'), '\n\+$', '', '') . '/lib/rustlib/src/rust/src'
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
  let g:lsp_diagnostics_enabled = 1
  let g:lsp_signs_enabled = 1           " enable signs
  let g:lsp_signs_error = {'text': '✗'}
  " }}}

  " Markdown Settings: {{{
  let g:vmt_auto_update_on_save = 0
  let g:mkdp_path_to_chrome = "vivaldi"
  let g:mkdp_auto_close = 1
  let g:mkdp_refresh_slow = 1
  nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
  imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
  nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
  imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode
  " }}}
 
endfunction
