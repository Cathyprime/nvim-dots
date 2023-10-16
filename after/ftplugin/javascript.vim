nmap <buffer> <silent> <localleader>p <Plug>(Js_nrepl)
vmap <buffer> <silent> <localleader>p <Plug>(Js_vrepl)

let b:dispatch = "node %"
nmap <buffer> <silent> <localleader>r :Dispatch<cr>
