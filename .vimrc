" Victor's VIM file
" ~/.vimrc or ~/.vim/vimrc
" In vimscript, line comments start with double quotes
" ========================== BASIC CONFIG ==========================
syntax on                       " enable syntax highlighting
set shortmess+=I                " disable default Vim startup message
set number relativenumber       " show line numbers and relative numbers
set ruler                       " show file stats
set nocompatible
" wildmenu turns on the fancy visual display of <TAB> matches when doing
" command-line completion:
set wildmenu
set wildmode=longest:list,full
set lazyredraw                  " redraw screen only when need to
set t_Co=256                    " assume we have 256 colors. The 1980's are over.
set history=300
set encoding=utf-8
set sidescrolloff=5
set scrolloff=8                 " keeps cursor more centered on the screen -- off by: 8
set title                       " set window's title to current file name
set clipboard=unnamed           " set clipbooard to general
set laststatus=2                " we always want a status line
set visualbell                  " blink cursor instead of beeping
set mouse+=a                    " enable mouse support
set noshowmode
set completeopt=menuone,noinsert,noselect
set colorcolumn=80
set signcolumn=yes              " adds extra column to the left
set cmdheight=2                 " give more space for displaying messages
set updatetime=50               " increases updatetime for UX (default is 400 ms)

" ================ LAYOUT/FORMATTING/WHITESPACE ================
" You probably want it to write current file when jumping to another, until
" you reach level 10:
set autowrite
set nowrap
set formatoptions=tcqrn1
set expandtab     " Insert spaces instead of tabs
set tabstop=4     " Number of spaces per tab
set softtabstop=4
set autoindent
set copyindent
set shiftwidth=4  " Number of spaces for autoindent
set shiftround    " Indenting should be multiple of shiftwidth
set smartindent
" set termguicolors
" set guicursor=


" ========================= CURSOR MOTION ===========================
" Allow backspace to back over newlines.  Otherwise, that's just weird:
set backspace=indent,eol,start
set matchpairs+=<:>     " use % to jump between pairs

inoremap jk <ESC>
inoremap JK <ESC>  " Map the capital version too -- although CAPSLOCK is evil
inoremap jj <Nop>  " Don't do anything for jj
nmap Q <Nop>       " Q in normal mode enters Ex mode. Don't want this

" In normal and visual mode, when wrap is ON, the per-line (instead of
" per-display) vertical movement is disorienting.
" This is cured by remapping j and k to gj and gk:
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" ========================= SEARCHING ==========================
set nohlsearch    " Do not use highlighting when doing a search 
set smartcase     " Enable case-insensitive search unless search text has caps
set incsearch     " Use incremental search
set ignorecase    " ignore capital letters during search
set showmatch     " Briefly highlight matching brackets/braces/parens
set showcmd       " show partial command you type in the last line of screen
set showmode      " show the mode you are in on the last line

" center the cursor vertically when moving to the next word during a search
nnoremap n nzz
nnoremap N Nzz

let mapleader=','   " the default leader is \\
" remap : to ; for easier searching
nnoremap ; :

" auto closing parens
inoremap { {}<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i

" Vim allows you to customize behavior based on the file type. Here's
" a simple example in which we honor the git world's convention for
" limiting line lengths in commit messages:
augroup gitcommit
    autocmd!
    au FileType gitcommit set textwidth=50
augroup END

" Turn on the spellchecker for markdown files:
augroup markdown
    autocmd!
    au FileType markdown set spell
augroup END

colorscheme torte
