compiler cargo
nnoremap <buffer> <silent> <localleader>r :Make run<cr>

setlocal include=\\v^\\s*(pub\\s+)?use\\s+\\zs(\\f\|:)+
setlocal includeexpr=rust#IncludeExpr(v:fname)

nmap <buffer> <silent> <cr> <Plug>(Rust_nrepl)
vmap <buffer> <silent> <cr> <Plug>(Rust_vrepl)
