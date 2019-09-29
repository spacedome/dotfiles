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
" Plug   'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} " for VimPlug

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

" Enable the mouse !
set mouse=a


" vimtex for minted
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

let g:tex_flavor='latex'
"let g:vimtex_view_method='zathura'
" let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
hi clear Conceal
hi Conceal ctermfg=6
set omnifunc=syntaxcomplete#Complete

let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/snips"]
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsEditSplit="vertical"
