highlight SLBackground guibg=#181818 guifg=#c8c093
highlight SLFileType guibg=#ce0406 guifg=black
highlight SLBufNumber guibg=SeaGreen guifg=#003333
highlight SLLineNumber guibg=#80a0ff guifg=#003366
highlight SLNormal guibg=#571cbd guifg=#181818
highlight SLInsert guibg=#7e9cd8 guifg=#181818
highlight SLVisual guibg=#76946a guifg=#181818
highlight SLVisualL guibg=#ad410e
highlight SLVisualB guibg=#181818 guifg=#80a0ff
highlight link SLSelect SLLineNumber
highlight SLReplace guibg=#ce0406 guifg=#181818
highlight SLCommand guifg=#181818 guibg=#ffa066
highlight SLTerminal guifg=#e6c384 guibg=#181818

function! statusline#Mode()
	hi clear SLMode
	if mode() ==# 'n' || mode() ==# 'niI' || mode() ==# 'niR' || mode() ==# 'niV' || mode() ==# 'nt' || mode() ==# 'ntT'
		hi link SLMode SLNormal
		return "norm"
	elseif mode() ==# 'v' || mode() ==# 'vs'
		hi link SLMode SLVisual
		return "vis "
	elseif mode() ==# 'V' || mode() ==# 'Vs'
		hi link SLMode SLVisualL
		return "visL"
	elseif mode() ==# '' || mode() ==# 's'
		hi link SLMode SLVisualB
		return "visB"
	elseif mode() ==# 's' || mode() ==# 'S' || mode() ==# ''
		hi link SLMode SLSelect
		return "sel "
	elseif mode() ==# 'i' || mode() ==# 'ic' || mode() ==# 'ix'
		hi link SLMode SLInsert
		return "ins "
	elseif mode() ==# 'R' || mode() ==# 'Rc' || mode() ==# 'Rx'
		hi link SLMode SLReplace
		return "rep "
	elseif mode() ==# 'c' || mode() ==# 'cv'
		hi link SLMode SLCommand
		return "com "
	elseif mode() ==# 't'
		hi link SLMode SLTerminal
		return "term"
	else
		hi SLMode guibg=black guifg=white
		return "[???]"
	endif
endfunction
