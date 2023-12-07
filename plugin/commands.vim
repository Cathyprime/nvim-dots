function! s:make_scratch(bang, mods)
	if ! a:bang
		exec a:mods .. " split"
	endif
	enew
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
endfunction

command! Messages let output = [] | redir => output | silent messages | redir END | cexpr output
command! -bang Scratch call <SID>make_scratch(<bang>0, <q-mods>)
