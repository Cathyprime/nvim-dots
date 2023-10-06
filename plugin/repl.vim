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

function! s:GetVisMode()
	if mode() ==# 'v' || mode() ==# 'V' || mode() ==# ''
		let l:mode = mode()
	else
		let l:mode = visualmode()
	endif
	echom l:mode
	return ""
endfunction

function! s:FullLines(start, stop, name)
	let start = a:start
	let stop = a:stop
	for line in range(start, stop + 1)
		let l:cmd = "echo \'" .. getline(line) .. "\' | ~/.tmux/scripts/repl.sh " .. a:name
		call system(l:cmd)
	endfor
endfunction

function! s:PartialLines(start_line, start_col, stop_line, stop_col, name)
	let text = []

	for line in range(a:start_line, a:stop_line)
		if a:start_line == a:stop_line
			let text += [strpart(getline(line), a:start_col - 1, a:stop_col - a:start_col + 1)]
		elseif line == a:start_line
			let text += [strpart(getline(line), a:start_col - 1)]
		elseif line == a:stop_line
			let text += [strpart(getline(line), 0, a:stop_col)]
		else
			let text += [getline(line)]
		endif
	endfor

	for line in text
		let l:cmd = "echo '" .. line .. "' | ~/.tmux/scripts/repl.sh " .. a:name
		call system(l:cmd)
	endfor
endfunction

function! s:ToRepl(...)
	let name = a:3
	echom name
	let start = a:1
	echom start
	let end = a:2
	echom end
	echom mode()
	if mode() ==# 'n'
		call s:FullLines(start, end, name)
	else
		if mode() ==# 'v'
			let [start_line, start_col] = getpos("'<")[1:2]
			let [stop_line, stop_col] = getpos("'>")[1:2]
			call s:PartialLines(start_line, start_col, stop_line, stop_col, name)
		elseif mode() ==# 'V'
			let start_line = getpos("'<")[1]
			let stop_line = getpos("'>")[1]
			call s:FullLines(start_line, stop_line)
		elseif mode() ==# '\<c-v>'
			echom "not implemented yet"
		endif
	endif
	return ""
endfunction

command! -nargs=+ -range SendToRepl call <sid>ToRepl(1, <line1>, <line2>, <q-args>)
command -nargs=1 StartREPL call <sid>StartREPL(<q-args>)

nnoremap <silent> <c-w>r :<c-u>StartREPL vim<cr>
nnoremap <silent> <c-w>R :<c-u>StartREPL lua<cr>
