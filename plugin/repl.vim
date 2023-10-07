command -nargs=+ -range SendToRepl call repl#repl#ToRepl(<line1>, <line2>, <q-args>)
command -nargs=1 StartREPL call repl#repl#StartREPL(<q-args>)
