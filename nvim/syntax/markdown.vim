if exists("b:current_syntax")
    finish
endif

syn match Keyword '\v- .*$'

let b:current_syntax = "mkd"
