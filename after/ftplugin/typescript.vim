let b:dispatch = "ts-node %"
nmap <buffer> <silent> <localleader>r :Dispatch<cr>

nmap <buffer> <silent> <localleader>p <Plug>(Ts_nrepl)
vmap <buffer> <silent> <localleader>p <Plug>(Ts_vrepl)
