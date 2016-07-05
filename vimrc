set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Vim leaders
let mapleader = ","

" ------------------------------------------------------------------------------
" General Settings
" ------------------------------------------------------------------------------
set history=100     " Default history is only 20
set undolevels=100  " Use more levels of undo
set laststatus=2    " always show status line @ botom
set scrolloff=3     " minimum number of lines to have above/below cursor
set nu              " line numbers
set relativenumber  " relative line numbers
set ruler           " cursor position
set lazyredraw
set hidden          " keep buffers around
set autoindent
set autoread
set backspace=indent,eol,start
set complete-=i
set display=lastline
set encoding=utf-8
set formatoptions=tcqj
set history=10000
set hlsearch
set incsearch
set langnoremap
set laststatus=2
set nrformats=hex
set sessionoptions-=options
set smarttab
set tabpagemax=50
set tags=./tags;,tags
set ttyfast
set viminfo+=!
set wildmenu
" set mouse=a         " mouse mode
set guioptions-=M   " remove gvim errata

" ------------------------------------------------------------------------------
" Indentation
" ------------------------------------------------------------------------------
set smartindent
set tabstop=2
set expandtab
set shiftwidth=2

" ------------------------------------------------------------------------------
" Search Settings
" ------------------------------------------------------------------------------
set ignorecase  " case insenitive search
set smartcase   " case sensitive search if capitol letter is there


" ------------------------------------------------------------------------------
" Vundle Packages
" ------------------------------------------------------------------------------
" they are in a seperate file (vimrc.bundles)
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" ------------------------------------------------------------------------------
" Color Scheme
" ------------------------------------------------------------------------------
" mokokai color scheme
" issue: make sure iterm (if on mac) has the correct color scheme
" b/c iterm overrides it (try git@github.com:stephenway/monokai.terminal.git)
colorscheme molokai
set background=dark
let g:airline_theme = "monochrome"
set cursorline " cursor highlighting
syntax on " syntax highlighting

" 256 color support
let term=$TERM
let colorterm=$COLORTERM
if term == "xterm-256color" || term == "screen-256color" || term == "screen" || colorterm == "xfce4-terminal" || colorterm == "gnome-terminal"
  set t_Co=256
endif

" draw a line at column 80
set textwidth=80
let &colorcolumn=join(range(80,80),",")

highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%120v.\+/

" ------------------------------------------------------------------------------
" Code Folding
" ------------------------------------------------------------------------------
set foldmethod=indent
set foldlevel=1
set nofoldenable
set foldnestmax=10

" fold code on space
nnoremap <space> za
vnoremap <space> zf

" don't ignore stuff in folds
set foldignore=

" save and restore folds when a file is closed and re-opened
autocmd BufWinLeave ?* mkview
autocmd BufWinEnter ?* silent loadview 

" ------------------------------------------------------------------------------
" Sourcing
" ------------------------------------------------------------------------------

" quickly source vimrc
nnoremap <leader>ev :e ~/.vimrc<cr><C-w>l :sp ~/.vimrc.bundles<cr>
nnoremap <leader>sv :!cp ~/setup/dotfiles/vimrc ~/.vimrc<cr>:!cp ~/setup/dotfiles/vimrc.bundles ~/.vimrc.bundles<cr>:source ~/.vimrc<cr>:echo "copied and sourced from ~/.vimrc and ~/.vimrc.bundles"<cr>


" ------------------------------------------------------------------------------
" Autocmds
" ------------------------------------------------------------------------------
augroup autocmds
  autocmd!

  " auto source vimrc on save
  autocmd bufwritepost .vimrc source ~/.vimrc

  " language settings for unhelpful languages
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufNewFile,BufRead *.scss set filetype=scss
  autocmd BufRead,BufNewFile *.cson set filetype=coffee
  autocmd BufRead,BufNewFile *.ex set syntax=elixir
  autocmd BufRead,BufNewFile *.exs set syntax=elixir
  autocmd BufRead,BufNewFile *.ejs set syntax=html

  " comments for elixir files
  autocmd BufRead,BufNewFile *.ex setlocal commentstring=#\ %s
  autocmd BufRead,BufNewFile *.exs setlocal commentstring=#\ %s

  " indent guides
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=235
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#4e4e4e ctermbg=239

  " no indent guides in git files
  fun! IndentGuides()
    if &ft =~ 'gitcommit' || &ft =~ 'gitmerge'
      return
    endif
    :IndentGuidesEnable
  endfun
  autocmd vimenter * call IndentGuides()

  " spell check in markdown and commits
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd FileType gitcommit setlocal spell

  " set relative and absolute numbers depending on mode
  autocmd InsertEnter * :set number
  autocmd InsertLeave * :set relativenumber
  au FocusLost * :set number
  au FocusGained * :set relativenumber
augroup end


" ------------------------------------------------------------------------------
" CTRL P
" ------------------------------------------------------------------------------
let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'dir':  '\v(\.(git|hg|svn)\|node_modules\|dist)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/dist/*,*/node_modules/*

" ctrlp buffer list
nnoremap <C-b> :CtrlPBuffer<CR>

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
let g:NERDTreeWinSize=31
let g:indent_guides_auto_colors = 0

" ------------------------------------------------------------------------------
" Movement
" ------------------------------------------------------------------------------

" remap split navigation keys
  map<c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" add resize keys
map - <c-w>-
map + <c-w>+
map < <c-w><
map > <c-w>>

" make W and Q work to write and save as well
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev wQ wq

" silver searcher keybindings
nmap <leader>f :Ag 

" clear search buffer
nmap <silent> <leader>/ :nohlsearch<CR>

" forgot sudo? just :w!!
cmap w!! w !sudo tee % >/dev/null

" ctrl-s will save
nnoremap <c-s> :w<CR>

" Easy indent/outdent
nnoremap <tab> >>
nnoremap <s-tab> <<
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" select entire
nmap <leader>e ggVG

" ------------------------------------------------------------------------------
" Buffer Management
" ------------------------------------------------------------------------------

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap ]b :bnext<CR>

" Move to the previous buffer
nmap [b :bprevious<CR>

" Close the current buffer and move to the previous one
nmap <leader>w :BW<cr>
nmap <leader>W :BW!<cr>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Find menu in current split, sp, snd vsp
" set path=$PWD
nnoremap fF :find .<cr>
nnoremap fS :sfind .<cr>
noremap fV :vert sfind .<cr>
" nnoremap ff :find <C-R>=expand('%:h').'/.'<CR><cr>
" nnoremap fs :sfind <C-R>=expand('%:h').'/.'<CR><cr>
" nnoremap fv :vert sfind <C-R>=expand('%:h').'/.'<CR><cr>


" ------------------------------------------------------------------------------
" Common Spelling Pitfalls
" ------------------------------------------------------------------------------
iab teh the
iab lgo log
iab tommorow tomorrow
iab lgo log
iab requrie require
iab cahnges changes

" ------------------------------------------------------------------------------
" Toggles
" ------------------------------------------------------------------------------
nnoremap <F3> :set paste!<CR>
nnoremap cop :set paste!<CR>

" ------------------------------------------------------------------------------
" easily create comment headers like these
" just do: title<ctrl-b>gc
" ------------------------------------------------------------------------------
nnoremap <leader>bb O<esc>76i-<esc>jo<esc>78i-<esc>Vkk
vnoremap <leader>bb <S-I><esc>O<esc>78i-<esc>gv<S-A><esc>o<esc>78i-<esc>gvkoj

" ------------------------------------------------------------------------------
" Other
" ------------------------------------------------------------------------------

" increment / decrement
nnoremap <leader>j <C-x>
nnoremap <leader>k <C-a>

" Make Y act like other capital letters
nnoremap Y y$

" ------------------------------------------------------------------------------
" Local config
" ------------------------------------------------------------------------------
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
