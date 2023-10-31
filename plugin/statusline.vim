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
highlight link SLMode SLNormal
highlight link SLModified SLFileType

" statusline
set statusline=
set statusline=\%#SLBackground#
set statusline+=\%#SLMode#
set statusline+=\ %{statusline#Mode()}\ 
set statusline+=\%#SLBackground#
set statusline+=\ %f\ %m%r
set statusline+=\%= " separator
set statusline+=\ %#SLFileType#
set statusline+=\ ft:\ %y
set statusline+=\ %#SLLineNumber#
set statusline+=\ %l\:%c
set statusline+=\ %#SLBufNumber#
set statusline+=\ bn:\ %n\ wn:\ %{winnr()}\ 

" winbar
set winbar=
set winbar+=%=
set winbar+=%f\ %m%r
set winbar+=%=

augroup StatusLine
	au!
	au ModeChanged * redrawstatus!
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
