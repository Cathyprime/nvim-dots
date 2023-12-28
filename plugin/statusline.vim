let enable = 0
let set_colors = 0

if set_colors
	highlight link SLBackground Normal
	highlight SLBackground guibg=#181818
	highlight SLFileType guibg=#ce0406 guifg=black
	highlight SLBufNumber guibg=SeaGreen guifg=#003333
	highlight SLLineNumber guibg=#80a0ff guifg=#003366
	highlight SLNormal guibg=#571cbd guifg=#c8c093
	highlight SLInsert guibg=#7e9cd8 guifg=#181818
	highlight SLVisual guibg=#76946a guifg=#181818
	highlight SLVisualLine guibg=#ad410e
	highlight SLVisualBlock guibg=#181818 guifg=#80a0ff
	highlight link SLSelect SLLineNumber
	highlight SLReplace guibg=#ce0406 guifg=#181818
	highlight SLCommand guifg=#181818 guibg=#ffa066
	highlight SLTerminal guifg=#e6c384 guibg=#181818
	highlight SLOperator guifg=#181818 guibg=#e6c384
	highlight link SLMode SLNormal
	highlight link SLModified SLFileType
	highlight link SLReg SLLineNumber
endif

if enable
	let statusstring = ""
	let statusstring ="\%#SLBackground#"
	let statusstring = statusstring .. "\%#SLMode#"
	let statusstring = statusstring .. "\ %{statusline#Mode()}\ "
	let statusstring = statusstring .. "\%#SLReg#"
	let statusstring = statusstring .. " %{v:register} "
	let statusstring = statusstring .. "\%#SLBackground#"
	let statusstring = statusstring .. "\ %f\ %m%r"
	let statusstring = statusstring .. "\%= "
	let statusstring = statusstring .. "\ %S"
	let statusstring = statusstring .. "\ %#SLFileType#"
	let statusstring = statusstring .. "\ %y"
	let statusstring = statusstring .. "\ %#SLLineNumber#"
	let statusstring = statusstring .. "\ (%l\:%c)"
	let statusstring = statusstring .. "\ %#SLBufNumber#"
	let statusstring = statusstring .. "\ [%{winnr()}:%n]\ "

	set statusline=
	let &statusline=statusstring

	augroup StatusLine
		au!
		au Filetype qf let &l:statusline = statusstring
		au ColorScheme * highlight link SLBackground Normal
					\ | highlight SLBackground guibg=#181818
					\ | highlight SLFileType guibg=#ce0406 guifg=black
					\ | highlight SLBufNumber guibg=SeaGreen guifg=#003333
					\ | highlight SLLineNumber guibg=#80a0ff guifg=#003366
					\ | highlight SLNormal guibg=#571cbd guifg=#c8c093
					\ | highlight SLInsert guibg=#7e9cd8 guifg=#181818
					\ | highlight SLVisual guibg=#76946a guifg=#181818
					\ | highlight SLVisualLine guibg=#ad410e
					\ | highlight SLVisualBlock guibg=#181818 guifg=#80a0ff
					\ | highlight link SLSelect SLLineNumber
					\ | highlight SLReplace guibg=#ce0406 guifg=#181818
					\ | highlight SLCommand guifg=#181818 guibg=#ffa066
					\ | highlight SLTerminal guifg=#e6c384 guibg=#181818
					\ | highlight link SLMode SLNormal
					\ | highlight link SLModified SLFileType
					\ | highlight WinBar guifg=#571cbd
	augroup END
endif
