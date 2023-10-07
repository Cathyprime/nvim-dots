command -nargs=+ -range SendToRepl call repl#ToRepl(<line1>, <line2>, <q-args>)
command -nargs=1 StartREPL call repl#StartREPL(<q-args>)

nnoremap <silent> <Plug>(VimREPL) :call repl#StartREPL("vim")<cr>
nnoremap <silent> <Plug>(LuaREPL) :call repl#StartREPL("lua")<cr>

" python
nnoremap <silent> <Plug>(Py_nrepl) :<c-u>call repl#ToReplMap("python", "n")<cr>
vnoremap <silent> <Plug>(Py_vrepl) :<c-u>call repl#ToReplMap("python", "v")<cr>
" scala
" rust
" R
