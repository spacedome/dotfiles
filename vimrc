" julien vimrc

set nocompatible
"filetype off
filetype plugin indent on
syntax on

set incsearch
set ruler
set wildmenu
set autoread
set autoindent
set smarttab

" let g:mapleader = " " " Set leader to spacebar 


" vim-plug

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'

Plug 'JuliaEditorSupport/julia-vim'

Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'w0rp/ale'
Plug 'lervag/vimtex'

" Initialize plugin system
call plug#end()


colorscheme nord

set colorcolumn=80
set spelllang=en_us
set backspace=indent,eol,start " Bring backspace to life
set number          " Line numbers
" set relativenumber  " Relative line numbers
set showcmd
set scrolloff=10

set laststatus=2 " for lightline
let g:lightline = { 'colorscheme' : 'nord' }

" Disable swap files
set noswapfile

" Disable arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
