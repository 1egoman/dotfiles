set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" General Settings "

set nu " line numbers
set ruler " cursor position
set ignorecase " case insenitive search
set smartcase " case sensitive search if capitol letter is there
syntax on " syntax highlighting

" Vundle Packages "
Bundle 'kien/ctrlp.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tomasr/molokai'

" mokokai color scheme
" issue: make sure iterm (if on mac) has the correct color scheme
" b/c iterm overrides it (try git@github.com:stephenway/monokai.terminal.git)
colorscheme molokai
