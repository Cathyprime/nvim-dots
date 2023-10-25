nmap <buffer> <silent> <localleader>p <Plug>(Python_nrepl)
vmap <buffer> <silent> <localleader>p <Plug>(Python_vrepl)

let b:dispatch = "python %"
nmap <buffer> <silent> <localleader>r :Dispatch<cr>
