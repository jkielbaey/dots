
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark    " Setting dark mode
syntax on
highlight ColorColumn ctermbg=237

set nocompatible
filetype off
set shell=/bin/bash

" call plug#begin('~/.config/nvim/plugged')
" 
" Plug 'sjl/badwolf'
" Plug 'fatih/molokai'
" Plug 'bling/vim-airline'
" Plug 'chase/vim-ansible-yaml'
" Plug 'klen/python-mode'
" Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'
" Plug 'godlygeek/tabular'
" Plug 'dag/vim-fish'
" Plug 'rking/ag.vim'
" Plug 'plasticboy/vim-markdown'
" Plug 'junegunn/goyo.vim'
" Plug 'elzr/vim-json'
" Plug 'ekalinin/Dockerfile.vim'
" Plug 'Powerline/powerline', { 'rtp': 'powerline/bindings/vim' }
"
" call plug#end()

set laststatus=2

" Enable syntax highlighting
" colorscheme molokai
highlight LineNr guifg=#b3b3b3<Paste>

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
