set background=light
packadd termdebug

set rnu nu
set cpo+=>
set diffopt+=iwhite
set diffopt+=algorithm:histogram
set diffopt+=indent-heuristic
set spell spl=en_us,en_gb,pl
set tabstop=4
set shiftwidth=4
set nosmartindent noautoindent cindent
set cinkeys=0{,0},0),0],:,0#,!^F,o,O,e,*<cr>
set cinoptions=i0.5s,p1s,g0.5s,h0.5s,L0,t0
set expandtab autoread exrc list
set listchars+=trail:-
set listchars+=tab:·\ \ 
set listchars+=precedes:←
set listchars+=extends:→
set listchars+=leadmultispace:·
set listchars+=nbsp:␣
set fillchars+=foldclose:>
set fillchars+=foldopen:v
set fillchars+=foldsep:\ 
set fillchars+=fold:\ 
set linebreak showbreak=->\ 
set path=.,**
set ignorecase smartcase incsearch
set foldlevel=4 foldexpr=v:lua.vim.treesitter.foldexpr()
set foldtext= foldmethod=expr foldcolumn=0 foldnestmax=4
set formatoptions-=l
set nohls cursorline guicursor=i-ci-ve:block showcmdloc=statusline
set cmdwinheight=2 cmdheight=2 showtabline=0
set scrolloff=8
set smoothscroll
set termguicolors
set signcolumn=yes
set inccommand=nosplit
set splitright
set nosplitbelow
set splitkeep=screen
set notimeout
set updatetime=700
set noswapfile
set nowritebackup
set shortmess+=c
set noshowmode
set laststatus=2
set undofile
set wildmode=longest,list,full
set wildoptions-=pum
set winminwidth=5
set pumheight=4
set wrap
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
let g:markdown_recommended_style=0

if hostname() == "luna"
    set guifont=Iosevka\ Nerd\ Font:h14
else
    set guifont=Iosevka\ Nerd\ Font:h18
endif

if exists(g:neovide)
    let g:neovide_scale_factor=1.0
    let g:neovide_hide_mouse_when_typing=v:true
    let g:neovide_refresh_rate=144
    let g:neovide_cursor_vfx_mode=""
    let g:neovide_fullscreen=v:true
    let g:neovide_floating_shadow=v:false
    let g:neovide_cursor_animation_length=0
    let g:neovide_cursor_trail_size=0.2
    let g:neovide_cursor_animate_command_line=v:false
    let g:neovide_scroll_animation_length=0
    let g:neovide_position_animation_length=0
endif
