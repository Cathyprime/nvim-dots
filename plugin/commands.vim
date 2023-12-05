command! Messages let output = [] | redir => output | silent messages | redir END | cexpr output
