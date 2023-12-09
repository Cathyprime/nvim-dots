function! statusline#Mode()
	hi clear SLMode
	if mode() ==# 'n' || mode() ==# 'niI' || mode() ==# 'niR' || mode() ==# 'niV' || mode() ==# 'nt' || mode() ==# 'ntT'
		hi link SLMode SLNormal
		return "[ Normal ]"
	elseif mode() ==# 'v' || mode() ==# 'vs'
		hi link SLMode SLVisual
		return "[ Visual ]"
	elseif mode() ==# 'V' || mode() ==# 'Vs'
		hi link SLMode SLVisualLine
		return "[ VisLin ]"
	elseif mode() ==# '' || mode() ==# 's'
		hi link SLMode SLVisualBlock
		return "[ VisBlk ]"
	elseif mode() ==# 's' || mode() ==# 'S' || mode() ==# ''
		hi link SLMode SLSelect
		return "--Select--"
	elseif mode() ==# 'i' || mode() ==# 'ic' || mode() ==# 'ix'
		hi link SLMode SLInsert
		return "--Insert--"
	elseif mode() ==# 'R' || mode() ==# 'Rc' || mode() ==# 'Rx'
		hi link SLMode SLReplace
		return "--Replce--"
	elseif mode() ==# 'c' || mode() ==# 'cv'
		hi link SLMode SLCommand
		return "--Cmmand--"
	elseif mode() ==# 't'
		hi link SLMode SLTerminal
		return "[ Termnl ]"
	else
		hi SLMode guibg=black guifg=white
		return "[???]"
	endif
endfunction
