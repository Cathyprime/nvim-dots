nmap <buffer> <silent> <localleader>p <Plug>(Python_nrepl)
vmap <buffer> <silent> <localleader>p <Plug>(Python_vrepl)
lua require("dap-python").setup("venv/bin/python")

let b:dispatch = "python %"
nmap <buffer> <silent> <localleader>r :Dispatch<cr>
