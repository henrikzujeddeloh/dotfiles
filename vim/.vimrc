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

" concealing links, italic, bold, etc
set conceallevel=2

" other highlighting
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1

" disable folding
let g:vim_markdown_folding_disabled = 1

" installs vim-plug (plugin manager for vim)

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" KEYBINDS

" remap undo keybind
nnoremap U <C-r>

" navigate visual lines instead of physical lines
noremap j gj
noremap k gk

" toggles directory
nnoremap 'n :NERDTreeToggle<CR>

" find file with fzf and edit
nnoremap 'e :Files ~<cr>

" find under current directory
nnoremap 'o :Files %:p:h<CR>

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
