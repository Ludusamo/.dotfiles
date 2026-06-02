" Language: .todo files
" Maintainer: Brendan Horng

" Checks if previous file has defined this syntax
if exists("b:current_syntax")
  finish
endif

" Set the name of the current syntax
let b:current_syntax="todo"

syn match unmatched '.'
syn match description ' |.*|'
syn match top_priority '^A \[ \]'
syn match medium_priority '^B \[ \]'
syn match regular_priority '^[C-Z] \[ \]'
syn match tag ' #[a-zA-Z-]*'
syn match date ' \d\{4\}-\d\{2\}-\d\{2\}'
syn match property '\s@[a-zA-Z]*\:".*"'
syn match subitem '^  \[ \] .*$'
syn match finished '^.*\[x\].*$'
hi unmatched ctermfg=white ctermbg=blue
hi top_priority ctermfg=red
hi medium_priority ctermfg=yellow
hi regular_priority ctermfg=white
hi tag ctermfg=green
hi date ctermfg=blue
hi property ctermfg=yellow
hi finished ctermfg=darkgray
