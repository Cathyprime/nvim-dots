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

" === scroll ===
nnoremap <C-b> <Nop>
nnoremap <C-f> <Nop>
nnoremap <c-d> <c-d>zz
nnoremap <c-u> <c-u>zz

" === text objects ===
" inner underscore
onoremap <silent> i_ :<c-u>norm! T_vt_<cr>
xnoremap <silent> i_ :<c-u>norm! T_vt_<cr>
" a underscore
onoremap <silent> a_ :<c-u>norm! F_vf_<cr>
xnoremap <silent> a_ :<c-u>norm! F_vf_<cr>

" === commands ===
function! s:ConfirmSave(yes, no, question)
	let user_input = input(a:question)
	while user_input !=# "yes" && user_input !=# "no"
		echo "Please answer yes or no."
		sleep 1
		let user_input = input(a:question)
	endwhile
	redraw
	if l:user_input == "yes"
		return a:yes
	else
		echom "Cancellng..."
		return a:no
	endif
endfunction

nnoremap <silent> <c-x><c-s> :w<cr>
nnoremap <silent> <c-x><c-e> :so<cr>
nnoremap <expr> <c-x>c <SID>ConfirmSave(":wq", ":q!", "Save buffer? (yes/no): ")
nnoremap <expr> <c-x><c-c> <SID>ConfirmSave(":wqa", ":qa!", "Save buffers? (yes/no): ")
nnoremap <m-x> q:i
nnoremap <c-x><c-x> <c-x>

" === marks ===
" nicer keymap
nnoremap ' `

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
let s:status = "on"
function! s:Presentation()
	if s:status == "on"
		set laststatus=0
		set cmdheight=0
		call system("tmux set -g status off")
		let s:status = "off"
	else
		set laststatus=3
		set cmdheight=1
		call system("tmux set -g status on")
		let s:status = "on"
	endif
endfunction
command! -nargs=0 Presentation call <SID>Presentation()
nnoremap <silent> <leader>ts :<c-u>Presentation<cr>

" clear line
nnoremap X 0D
" join lines
nnoremap J mzJ`z
" select pasted test
nnoremap gp `[v`]
" redo
nnoremap U <c-r>

" === substitute commands ===
" search and replace word under cursor in the file
nnoremap <leader>s :%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>
" replace all marked instances
vnoremap <leader>s y:%s/<c-r>"/<c-r>"/gc<left><left><left>
