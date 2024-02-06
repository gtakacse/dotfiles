""" VIM OPTIONS 
"============== 

" PLUGINS 
" =======
execute pathogen#infect()
" night-owl.vim
" vim-airline
" vim-airline-themes
" fzf
" fzf.vim
" fugitive.vim
" vim-commentary
" vim-surround

" Color schemes
if (has("termguicolors"))
  set termguicolors
  set t_Co=256
endif
colorscheme night-owl
set laststatus=2
let g:airline_theme = 'lighthaus'

" Syntax highlighting
syntax on
syntax enable

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Add numbers to each line on the left-hand side.
set relativenumber number

" Tab settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set timeoutlen=1000
set ttimeoutlen=0  

set hidden "open new buffer without saving current

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Line wrap
set wrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase
set wrapscan

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

"Prompt
let &t_SI .= "\<Esc>[6 q"
let &t_EI .= "\<Esc>[2 q"
let &t_SR .= "\<Esc>[4 q"


" Mappings
let mapleader = "\<space>"
inoremap jk <esc>
nnoremap <esc><esc> :noh<CR><esc>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>x :bdelete<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>fm gg=G " reindent file

