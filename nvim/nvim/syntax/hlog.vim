" Language: .hlog files
" Maintainer: Brendan Horng

" Checks if previous file has defined this syntax
if exists("b:current_syntax")
  finish
endif

" Set the name of the current syntax
let b:current_syntax="hlog"

syn match tag ' #[a-zA-Z-]*'
syn match datetime '\d\{4\}-\d\{2\}-\d\{2\}T\d\{2\}:\d\{2\}:\d\{2\}-\d\{4\}'
syn match property '\s@[a-zA-Z]*\:".*"'
hi tag ctermfg=green
hi datetime ctermfg=blue
hi property ctermfg=yellow
