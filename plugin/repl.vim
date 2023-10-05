function! s:StartREPL(filetype)
	if a:filetype == "vim"
		let l:temp_file = tempname() .. ".vim"
	elseif a:filetype == "lua"
		let l:temp_file = tempname() .. ".lua"
	else
		echo "Neovim can only source vim or lua files!"
		return
	endif
	exec 'split ' .. l:temp_file
	nmap <silent> <buffer> <c-s> :<c-u>sav! ~/.config/nvim/repl_output<cr>
	augroup TempREPL
		au!
		au BufWritePost <buffer> source %
	augroup END
endfunction

" function! s:FullLines(start, stop, name)
" 	let start = a:start - 1
" 	let stop = a:stop - 1
" 	for line in range(start, stop + 1)
" 		silent exec line .. 'w !~/.tmux/scripts/repl.sh ' .. a:name
" 	endfor
" endfunction

" function! s:PartialLines(start_line, start_col, stop_line, stop_col, name)
" 	let text = []
"
" 	for line in range(a:start_line, a:stop_line)
" 		if a:start_line == a:stop_line
" 			" Only one line is selected
" 			let text += [strpart(getline(line), a:start_col - 1, a:stop_col - a:start_col + 1)]
" 		elseif line == a:start_line
" 			" First line
" 			let text += [strpart(getline(line), a:start_col)]
" 		elseif line == a:stop_line
" 			" Last line
" 			let text += [strpart(getline(line), 0, a:stop_col)]
" 		else
" 			" Middle lines
" 			let text += [getline(line)]
" 		endif
" 	endfor
"
" 	for line in text
" 		echom line
" 	endfor
" endfunction

" function! s:ToRepl(...)
" 	let name = a:1
" 	let start = line(".")
" 	let end = line(".")
" 	if a:0 > 2
" 		let start = a:2
" 		let end = a:3
" 		call s:FullLines(start, end, name)
" 	elseif mode() ==# 'v'
" 		let [start_line, start_col] = getpos("'<")[1:2]
" 		let [stop_line, stop_col] = getpos("'>")[1:2]
" 		call s:PartialLines(start_line, start_col, stop_line, stop_col, name)
" 	elseif mode() ==# 'V'
" 		let start_line = getpos("'<")[1]
" 		let stop_line = getpos("'>")[1]
" 		call s:FullLines(start_line, stop_line)
" 	endif
" endfunction

command -nargs=1 -range=1 SendToRepl call <sid>ToRepl(<q-args>, <range>)
command -nargs=1 StartREPL call <sid>StartREPL(<q-args>)

nnoremap <silent> <c-w>r :<c-u>StartREPL vim<cr>
nnoremap <silent> <c-w>R :<c-u>StartREPL lua<cr>
