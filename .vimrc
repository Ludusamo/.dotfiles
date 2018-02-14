" Usual Configurations
set nocompatible

syntax enable
filetype plugin on

set path+=**
set wildmenu

set relativenumber
set nu
set expandtab tabstop=4 shiftwidth=4 softtabstop=4
set colorcolumn=80

" Special syntax highlighting
autocmd BufNewFile,BufRead *.ino set syntax=c

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Leader mappings
let mapleader = " "
nnoremap <Leader>tn :tabnew<CR>
nnoremap <leader>l :set list!<CR>
nnoremap <leader>zz m`:TrimSpaces<CR>``
nnoremap <leader>rr :so %<CR>
nnoremap <silent> <leader>rt :! ctags -R .<CR>

" Whitespace
set list!
set listchars=tab:▸\ ,trail:•

function ShowSpaces(...)
    let @/='\v(\s+$)|( +\ze\t)'
    let oldhlsearch=&hlsearch
    if !a:0
        let &hlsearch=!&hlsearch
    else
        let &hlsearch=a:1
    end
    return oldhlsearch
endfunction

function TrimSpaces() range
    let oldhlsearch=ShowSpaces(1)
    execute a:firstline.",".a:lastline."substitute ///gec"
    let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

" Vim Plug
call plug#begin()

Plug 'elmcast/elm-vim'
Plug 'vim-syntastic/syntastic'
Plug 'Valloric/YouCompleteMe'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

Plug 'tpope/vim-surround'

call plug#end()

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:elm_syntastic_show_warnings = 1

" YouCompleteMe
let g:ycm_semantic_triggers = {
     \ 'elm' : ['.'],
     \}

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" Vim Markdown
let g:vim_markdown_folding_disabled = 1
