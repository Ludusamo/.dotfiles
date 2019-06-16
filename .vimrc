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

" Disable
inoremap hn <esc>
inoremap <esc> <nop>

" Colemak
augroup colemak
    " Normal
    nnoremap n j
    nnoremap i l
    nnoremap e k
    nnoremap k n
    nnoremap l u
    nnoremap u i
    nnoremap j e
    nnoremap U I

    nnoremap <S-n> <S-j>
    nnoremap <S-i> <S-l>
    nnoremap <S-e> <S-k>
    nnoremap <S-k> <S-n>
    nnoremap <S-l> <S-u>
    nnoremap <S-u> <S-i>
    nnoremap <S-j> <S-e>

    " Visual
    vnoremap n j
    vnoremap i l
    vnoremap e k
    vnoremap k n
    vnoremap l u
    vnoremap u i
    vnoremap j e

    " Operator Pending
    onoremap n j
    onoremap i l
    onoremap e k
    onoremap k n
    onoremap l u
    onoremap u i
    onoremap j e
augroup END

" Folding
set foldmethod=indent
set foldlevelstart=99

" Special syntax highlightine
au BufRead,BufNewFile *.screeps.js set syntax=screeps
autocmd BufNewFile,BufRead *.ino syntax=c
augroup autocommands
    autocmd!
    autocmd BufWritePre *.go :GoFmt
augroup END

nnoremap <c-h> <c-w>h
nnoremap <c-n> <c-w>j
nnoremap <c-e> <c-w>k
nnoremap <c-i> <c-w>l

" Leader mappings
augroup colemak
    let mapleader = " "
    nnoremap <leader>tn :tabnew<CR>
    nnoremap <leader>l :set list!<CR>
    nnoremap <leader>zz m`:TrimSpaces<CR>``
    nnoremap <silent> <leader>rr :so %<CR>
    nnoremap <silent> <leader>rt :! ctags -R .<CR>
    nnoremap <leader>ev :vsplit $MYVIMRC<CR>
    nnoremap <leader>oa :A<CR>
    nnoremap <leader>w :w<CR>
augroup END

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

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'ervandew/supertab'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'vim-scripts/Conque-GDB'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'

Plug 'freitass/todo.txt-vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" Lets vim know it can display 256 colors
set t_Co=256

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:elm_syntastic_show_warnings = 1

" YouCompleteMe
let g:ycm_semantic_triggers = {
     \ 'elm' : ['.'],
     \}

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" Vim Markdown
let g:vim_markdown_folding_disabled = 1

" UltiSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:UltiSnipsEditSplit="vertical"

" Airline
let g:airline_theme='atomic'
