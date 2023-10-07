command -nargs=+ -range SendToRepl call repl#ToRepl(<line1>, <line2>, <q-args>)
command -nargs=1 StartREPL call repl#StartREPL(<q-args>)

nnoremap <silent> <Plug>(VimREPL) :call repl#StartREPL("vim")<cr>
nnoremap <silent> <Plug>(LuaREPL) :call repl#StartREPL("lua")<cr>

" python
nnoremap <silent> <Plug>(Python_nrepl) :<c-u>call repl#ToReplMap("python", "n")<cr>
vnoremap <silent> <Plug>(Python_vrepl) :<c-u>call repl#ToReplMap("python", "v")<cr>
" scala
nnoremap <silent> <Plug>(Scala_nrepl) :<c-u>call repl#ToReplMap("amm-31", "n")<cr>
vnoremap <silent> <Plug>(Scala_vrepl) :<c-u>call repl#ToReplMap("amm-31", "v")<cr>
" rust
nnoremap <silent> <Plug>(Rust_nrepl) :<c-u>call repl#ToReplMap("irust", "n")<cr>
vnoremap <silent> <Plug>(Rust_vrepl) :<c-u>call repl#ToReplMap("irust", "v")<cr>
" R
nnoremap <silent> <Plug>(R_nrepl) :<c-u>call repl#ToReplMap("R", "n")<cr>
vnoremap <silent> <Plug>(R_vrepl) :<c-u>call repl#ToReplMap("R", "v")<cr>
" javascript
nnoremap <silent> <Plug>(Js_nrepl) :<c-u>call repl#ToReplMap("node", "n")<cr>
vnoremap <silent> <Plug>(Js_vrepl) :<c-u>call repl#ToReplMap("node", "v")<cr>
" typescript
nnoremap <silent> <Plug>(Ts_nrepl) :<c-u>call repl#ToReplMap("ts-node", "n")<cr>
vnoremap <silent> <Plug>(Ts_vrepl) :<c-u>call repl#ToReplMap("ts-node", "v")<cr>
