function! repl#FullLines(start, stop, name)
	let text = []
	for line in range(a:start, a:stop)
		let text += [getline(line)]
	endfor
	for line in text
		let l:cmd = "echo '" .. l:line .. "' | ~/.tmux/scripts/repl.sh " .. a:name
		echo l:line
		let l:result = system(l:cmd)
	endfor
endfunction

function! repl#PartialLines(start_line, start_col, stop_line, stop_col, name)
	let text = []

	for line in range(a:start_line, a:stop_line)
		if a:start_line == a:stop_line
			let text += [strpart(getline(line), a:start_col - 1, a:stop_col - a:start_col + 1)]
		elseif line == a:start_line
			let text += [strpart(getline(line), a:start_col - 1)]
		elseif line == a:stop_line
			let text += [strpart(getline(line), 0, a:stop_col + 1)]
		else
			let text += [getline(line)]
		endif
	endfor

	for line in text
		let l:cmd = "echo '" .. l:line .. "' | ~/.tmux/scripts/repl.sh " .. a:name
		call system(l:cmd)
	endfor
endfunction

function! repl#ToRepl(line1, line2, name)
	let start = a:line1
	let stop = a:line2
	for line in range(start, stop)
		let l:cmd = "echo \'" .. getline(line) .. "\' | ~/.tmux/scripts/repl.sh " .. a:name
		call system(l:cmd)
	endfor
	return ""
endfunction

function! repl#ToReplMap(name, norm)
	if a:norm ==# "n"
		let l:line = line(".")
		call repl#FullLines(l:line, l:line, a:name)
		" return ":<c-u>call system(" .. l:cmd .. ")" .. "<cr>"
	elseif visualmode() ==# 'v'
		let [start_line, start_col] = getpos("'<")[1:2]
		let [stop_line, stop_col] = getpos("'>")[1:2]
		call repl#PartialLines(start_line, start_col, stop_line, stop_col, a:name)
		" return ""
	elseif visualmode() ==# 'V'
		let l:start = line("'<")
		let l:stop = line("'>")
		call repl#FullLines(l:start, l:stop, a:name)
		" return ":w !~/.tmux/scripts/repl.sh " .. a:name .. "<cr>"
	endif
endfunction

function! repl#StartREPL(filetype)
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
