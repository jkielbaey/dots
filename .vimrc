set nocompatible
filetype off
set shell=/bin/bash

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Powerline/powerline', { 'rtp': 'powerline/bindings/vim' }

call vundle#end() 

" Activate powerline
source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2

filetype plugin indent on
