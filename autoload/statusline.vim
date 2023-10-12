function! statusline#Mode()
	hi clear SLMode
	if mode() ==# 'n' || mode() ==# 'niI' || mode() ==# 'niR' || mode() ==# 'niV' || mode() ==# 'nt' || mode() ==# 'ntT'
		hi link SLMode SLNormal
		return "-[ norm ]-"
	elseif mode() ==# 'v' || mode() ==# 'vs'
		hi link SLMode SLVisual
		return "-[ vis ]--"
	elseif mode() ==# 'V' || mode() ==# 'Vs'
		hi link SLMode SLVisualLine
		return "-[ visL ]-"
	elseif mode() ==# '' || mode() ==# 's'
		hi link SLMode SLVisualBlock
		return "-[ visB ]-"
	elseif mode() ==# 's' || mode() ==# 'S' || mode() ==# ''
		hi link SLMode SLSelect
		return "-- slct --"
	elseif mode() ==# 'i' || mode() ==# 'ic' || mode() ==# 'ix'
		hi link SLMode SLInsert
		return "-- isrt --"
	elseif mode() ==# 'R' || mode() ==# 'Rc' || mode() ==# 'Rx'
		hi link SLMode SLReplace
		return "-- rplc --"
	elseif mode() ==# 'c' || mode() ==# 'cv'
		hi link SLMode SLCommand
		return "-- comm --"
	elseif mode() ==# 't'
		hi link SLMode SLTerminal
		return "-- term --"
	else
		hi SLMode guibg=black guifg=white
		return "[???]"
	endif
endfunction
