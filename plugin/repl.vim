function! g:StartREPL(filetype)
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

command -nargs=1 StartREPL call StartREPL(<q-args>)

nnoremap <silent> <c-w>r :<c-u>StartREPL vim<cr>
nnoremap <silent> <c-w>R :<c-u>StartREPL lua<cr>
