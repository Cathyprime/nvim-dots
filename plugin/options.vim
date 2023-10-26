" line numbers
set rnu
set nu

" tabs & indentation
set tabstop=4
set shiftwidth=4
set smartindent
" set expandtab

" exrc
set exrc

" line wrapping
set wrap
set textwidth=100

" list
set list
set listchars+=trail:-,tab:\\u0020\\u0020

" path
set path=.,**

" search settings
set noignorecase
set smartcase
set incsearch
set hls

" cursor
set cursorline
set guicursor=i-ci-ve:block

" scrolloff
set scrolloff=6

" sql filetype rebind
" vim.cmd("let g:ftplugin_sql_omni_key='<C-p>'")

" appearance
set termguicolors
set signcolumn=yes
" set colorcolumn=100

" incremental substitute
set inccommand=split

" split windows
set splitright
set splitbelow

" update time
set updatetime=50

" swap & backup
set noswapfile
set nowritebackup

" short message
set shortmess+=c

" mode
set noshowmode

" global status line
set laststatus=3

" undo
set undofile
set undodir=$HOME/.config/nvim/undo

" completion settings
set wildmode=longest:full,full
set completeopt=menu

" Minimum window width
set winminwidth=5

" popup menu
set pumheight=8

" Disable line wrap
set nowrap

" Fix markdown indentation settings
let g:markdown_recommended_style=0

" disable netrw
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1

" grepprg
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
