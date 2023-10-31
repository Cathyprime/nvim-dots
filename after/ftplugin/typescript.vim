let b:dispatch = "ts-node %"
nmap <buffer> <silent> <localleader>r :Dispatch<cr>

compiler ts-node
nmap <buffer> <silent> <localleader>p <Plug>(Ts_nrepl)
vmap <buffer> <silent> <localleader>p <Plug>(Ts_vrepl)
