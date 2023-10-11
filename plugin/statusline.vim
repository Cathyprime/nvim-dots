highlight link SLMode SLNormal
set statusline=
set statusline=\%#SLBackground#
set statusline+=\%#SLMode#
set statusline+=\ %{statusline#Mode()}\ 
set statusline+=\%#SLBackground#
set statusline+=\ %F
set statusline+=\%= " separator
set statusline+=\ %#SLFileType#
set statusline+=\ FT:\ %Y
set statusline+=\ %#SLBufNumber#
set statusline+=\ BN:\ %n
set statusline+=\ %#SLLineNumber#
set statusline+=\ LN:\ %l\ 
