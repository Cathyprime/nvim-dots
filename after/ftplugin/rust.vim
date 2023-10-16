compiler cargo
nnoremap <buffer> <silent> <localleader>r :Dispatch<cr>
let b:dispatch = "cargo run"

setlocal include=\\v^\\s*(pub\\s+)?use\\s+\\zs(\\f\|:)+
setlocal includeexpr=rust#IncludeExpr(v:fname)

nmap <buffer> <silent> <localleader>p <Plug>(Rust_nrepl)
vmap <buffer> <silent> <localleader>p <Plug>(Rust_vrepl)
