setlocal makeprg=npm

let b:dispatch = "node %"
nmap <buffer> <silent> <localleader>r :Dispatch<cr>
