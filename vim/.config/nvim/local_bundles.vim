" Color scheme
Plug 'joshdick/onedark.vim'

" Sort out the powerline fonts
Plug 'powerline/powerline'

" Folding
Plug 'pseewald/vim-anyfold'

" Rust completion for Racer
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" markdown preview
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Zen Mode
Plug 'junegunn/goyo.vim'

" Dockerfile support
Plug 'ekalinin/Dockerfile.vim'


