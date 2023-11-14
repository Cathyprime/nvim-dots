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

" === substitute commands ===
" search and replace word under cursor in the file
nnoremap <leader>s :%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>
" replace all marked instances
vnoremap <leader>s y:%s/<c-r>"/<c-r>"/gc<left><left><left>
