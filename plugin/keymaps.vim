function! MacroOnLines()
	let reg = nr2char(getchar())
	if empty(reg)
		echo "no register selected"
		return
	endif
	let l:start = line("'<")
	let l:end = line("'>")
	for l:line in range(l:start, l:end)
		execute l:line . 'normal @' . reg . "\<cr>"
	endfor
endfunction

xnoremap <silent> @ :<c-u>call MacroOnLines()<cr>

" === quickfix ===
nnoremap <silent> ]c :cnext<cr>
nnoremap <silent> [c :cprev<cr>

" === disable scroll full page ===
nnoremap <C-b> <Nop>
nnoremap <C-f> <Nop>

" === recenter screen ===
" scroll down
nnoremap <C-d> <C-d>zz
" scroll up
nnoremap <C-u> <C-u>zz
" next search
nnoremap n nzzzv
" prev search
nnoremap N Nzzzv

" === text objects ===
" inner line
onoremap <silent> iL :<c-u>norm! _vg_<cr>
xnoremap <silent> iL :<c-u>norm! _vg_<cr>
" a line
onoremap <silent> as :<c-u>norm! 0v$<cr>
xnoremap <silent> as :<c-u>norm! 0v$<cr>
" inner underscore
onoremap <silent> i_ :<c-u>norm! T_vt_<cr>
xnoremap <silent> i_ :<c-u>norm! T_vt_<cr>
" a underscore
onoremap <silent> a_ :<c-u>norm! F_vf_<cr>
xnoremap <silent> a_ :<c-u>norm! F_vf_<cr>

" === clipboard interaction ===
" " yank to clipboard
nnoremap  <leader>y "+y
vnoremap  <leader>y "+y
" " Yank to clipboard
nnoremap <leader>Y "+yy
" " paste from clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
" " Paste from clipboard
nnoremap <leader>P "+P
vnoremap <leader>P "+P

" === misc ===
" join lines
nnoremap J mzJ`z
" select pasted test
nnoremap gp `[v`]
" redo
nnoremap U <c-r>

" === substitute commands ===
" replace inline instances under cursor
nnoremap <leader>s :%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>
" replace all instances under cursor
vnoremap <leader>s y:%s/<c-r>"/<c-r>"/g<left><left>
