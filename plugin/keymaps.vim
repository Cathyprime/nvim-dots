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
function! s:OpenQuickfix()
	if exists('b:dispatch_ready') && b:dispatch_ready
		let b:dispatch_ready = 0
		return ":Cope"
	else
		return ":cope"
	endif
endfunction
nnoremap <silent> ]c :cnext<cr>
nnoremap <silent> [c :cprev<cr>
nnoremap <silent> <expr> <leader>q <SID>OpenQuickfix()

" === disable scroll full page ===
nnoremap <C-b> <Nop>
nnoremap <C-f> <Nop>

" === recenter screen ===
" scroll down
nnoremap <C-d> <C-d>zz
" scroll up
nnoremap <C-u> <C-u>zz

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

" === commands ===
function! s:ConfirmSave(quit, question)
	let user_input = input(a:question)
	while user_input !=# "yes" && user_input !=# "no"
		let user_input = input('Please choose "yes" or "no": ')
	endwhile
	redraw
	if l:user_input == "yes"
		return a:quit
	else
		echom "Cancellng..."
		return ""
	endif
endfunction

nmap <expr> <c-x>s <SID>CofirmSave(":w", "Save buffer? (yes/no): ")
nmap <expr> <c-x>c <SID>ConfirmSave(":wq", "Save buffer and exit? (yes/no): ")
nnoremap <silent> <c-x><c-s> :w<cr>
nnoremap <silent> <c-x><c-c> :wq<cr>

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

" === compile ===
function! s:DispatchWrapper()
	let b:dispatch_ready = 1
	if exists("b:dispatch")
		return ":Dispatch!"
	endif
	let l:command = input(":Dispatch ")
	redraw
	let b:dispatch = l:command
	return ":Dispatch!"
endfunction

function! s:DispatchWrapperChange()
	let b:dispatch_ready = 1
	if !exists("b:dispatch")
		return s:DispatchWrapper()
	endif
	let l:command = input(":Dispatch ")
	redraw
	let b:dispatch = l:command
	return ":Dispatch!"
endfunction

function! s:MakeWrapper()
	let b:dispatch_ready = 1
	let l:command = input(":Make! ")
	redraw
	return ":Make! " .. l:command .. ""
endfunction

nnoremap <c-c>s :Start 
nnoremap <expr> <c-c>m <SID>MakeWrapper()
nnoremap <c-c>f :Focus 
nnoremap <silent> <c-c>F :Focus!<cr>
nnoremap <silent> <expr> <c-c>d <SID>DispatchWrapper()
nnoremap <silent> <expr> <c-c>D <SID>DispatchWrapperChange()

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
