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

" enable auto copmletion menu after pressing TAB
set wildmenu
set wildmode=list:longest

" enable mouse control
set mouse=a

" show hidden files in NERDTree by default
let NERDTreeShowHidden=1

" tabs appear as 4 spaces
set tabstop=4
set shiftwidth=4


" installs vim-plug (plugin manager for vim)

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" KEYBINDS

" remap undo keybind
nnoremap U <C-r>

" toggles directory
nnoremap 'n :NERDTreeToggle<CR>

" find file with fzf and edit
nnoremap 'e :FZF ~<cr>

" find buffers
nnoremap 'b :Buffers<cr>

" toggle previous buffer
nnoremap '' :b#<cr>

" move to next buffer
nnoremap 'j :bn<cr>

" close buffer but not window
nnoremap 'q :bn<bar>bd#<cr>

" open terminal
nnoremap 't :term<cr>

" scroll terminal
tnoremap <Esc><Esc> <C-w>N

" navigate visual lines instead of physical lines
noremap j gj
noremap k gk

" Installs plugins

call plug#begin()

Plug 'vim-airline/vim-airline'

Plug 'airblade/vim-gitgutter'

Plug 'preservim/nerdtree'

Plug 'tpope/vim-surround'

Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'

Plug 'cespare/vim-toml'

Plug 'ervandew/supertab'

Plug 'godlygeek/tabular'

Plug 'preservim/vim-markdown'

call plug#end()
