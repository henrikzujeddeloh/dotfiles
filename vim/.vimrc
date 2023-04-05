" enables syntax highlighting
syntax on

" highlights line and colomn of cursor
set cursorline
" set cursorcolumn

" set hybrid relative line number
set number

" highlight matching brace
set showmatch

" ignore case when searching
set ignorecase

" set scroll offset
set scrolloff=4

" disable compatibility with vi
set nocompatible

" enable auto copmletion menu after pressing TAP
set wildmenu
set wildmode=list:longest





" installs vim-plug (plugin manager for vim)

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" KEYBINDS

" find file with fzf and edit
nnoremap 'e :FZF ~<cr>

" find buffers
nnoremap 'b :Buffers<cr>

" toggle previous buffer
nnoremap '' :b#<cr>

" scroll terminal
tnoremap <Esc><Esc> <C-w>N

" Installs plugins

call plug#begin()

Plug 'vim-airline/vim-airline'

Plug 'airblade/vim-gitgutter'

Plug 'preservim/nerdtree'

Plug 'tpope/vim-surround'

Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'

Plug 'cespare/vim-toml'

call plug#end()
