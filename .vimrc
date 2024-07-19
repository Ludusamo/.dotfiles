" Usual Configurations
set nocompatible

" Vim Plug
call plug#begin()

Plug 'Valloric/YouCompleteMe' " Code completion

Plug 'dense-analysis/ale' " Linting

Plug 'godlygeek/tabular' " Takes things and nicely spaces them out
Plug 'plasticboy/vim-markdown'

Plug 'tpope/vim-surround'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'ervandew/supertab' " Allows for usage of tab in insertion mode

" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive' " Git Integration
Plug 'tpope/vim-projectionist' " Project Configuration

" Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'leafgarland/typescript-vim'
Plug 'elmcast/elm-vim'
Plug 'posva/vim-vue'
Plug 'zah/nim.vim'
Plug 'elixir-editors/vim-elixir'

Plug 'segeljakt/vim-silicon' " Cool screenshots

Plug 'phanviet/vim-monokai-pro' " Awesome Colorscheme

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Fuzzy File Finder

Plug 'jpalardy/vim-slime' " Sending text to other tmux panes

Plug 'tpope/vim-repeat'

Plug 'shime/vim-livedown'

Plug 'dart-lang/dart-vim-plugin'

call plug#end()

" Lets vim know it can display 256 colors
" set termguicolors
set t_Co=256
colorscheme slate

" Ale
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_virtualtext_cursor = 1
let g:ale_fix_on_save = 1

" Perl
let g:ale_perl_perl_options = '-c -Mwarnings -Ilib -It/lib'
let g:ale_linters = { 'perl': ['perl'] }

" YouCompleteMe
let g:ycm_semantic_triggers = {
     \ 'elm' : ['.'],
     \}

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabClosePreviewOnPopupClose = 1

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

" Slime
let g:slime_target="tmux"
let g:slime_paste_file = "$HOME/tmp/.slime_paste"

set grepprg=rg\ --hidden\ --glob\ '!.git'\ --vimgrep\ --with-filename
set grepformat=%f:%l:%c:%m
syntax enable
filetype plugin on

" Fuzzy file searching with :find
set path+=**
set wildignore+=**/node_modules/**
set wildmenu

" File Locations
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

" Common
set relativenumber
set nu
set tabstop=2 shiftwidth=2 softtabstop=2 smarttab expandtab

" Line highlight
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Whitespace
set list!
set listchars=tab:▸\ ,trail:•

function! ShowSpaces(...)
    let @/='\v(\s+$)|( +\ze\t)'
    let oldhlsearch=&hlsearch
    if !a:0
        let &hlsearch=!&hlsearch
    else
        let &hlsearch=a:1
    end
    return oldhlsearch
endfunction

function! TrimSpaces() range
    let oldhlsearch=ShowSpaces(1)
    execute a:firstline.",".a:lastline."substitute ///gec"
    let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

" Key Mappings =======================================================

" Disable
inoremap hn <esc>
inoremap <esc> <nop>

" Easier pane movement
nnoremap <c-h> <c-w>h
nnoremap <c-n> <c-w>j
nnoremap <c-e> <c-w>k
nnoremap <c-i> <c-w>l

nnoremap <c-p> :Files<CR>

nnoremap ; :
nnoremap : ;

nnoremap <Enter> @@

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

    nnoremap <c-l> <c-u>
    nnoremap <c-u> <c-i>

    " Visual
    vnoremap n j
    vnoremap i l
    vnoremap e k
    vnoremap k n
    vnoremap l u
    vnoremap u i
    vnoremap j e

    vnoremap <S-n> <S-j>
    vnoremap <S-i> <S-l>
    vnoremap <S-e> <S-k>
    vnoremap <S-k> <S-n>
    vnoremap <S-l> <S-u>
    vnoremap <S-u> <S-i>
    vnoremap <S-j> <S-e>

    vnoremap <c-l> <c-u>
    vnoremap <c-u> <c-i>


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

" Special syntax highlighting
au BufRead,BufNewFile *.screepsjs set syntax=screeps
au BufNewFile,BufRead *.ino set filetype=c
au BufNewFile,BufRead *.h set filetype=c
augroup autocommands
    autocmd!
    autocmd BufWritePre *.go :GoFmt
augroup END

" Leader mappings
augroup leader
    let mapleader = " "
    nnoremap <leader>tn :tabnew<CR>
    nnoremap <leader>l :set list!<CR>
    nnoremap <leader>zz m`:TrimSpaces<CR>``
    nnoremap <silent> <leader>rr :so %<CR>
    nnoremap <silent> <leader>rt :! ctags -R .<CR>
    nnoremap <leader>ev :vsplit $HOME/.vimrc<CR>
    nnoremap <leader>oa :A<CR>
    nnoremap <leader>w :w<CR>
    nnoremap <leader>n :cn<CR>
    nnoremap <leader>p :cp<CR>
augroup END

" make fzf match the color scheme
 let g:fzf_colors =
\ {
\ 'fg':       ['fg', 'Normal'],
\ 'bg':       ['bg', 'Normal'],
\ 'hl':       ['fg', 'Comment'],
\ 'fg+':      ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':      ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':      ['fg', 'Statement'],
\ 'info':     ['fg', 'PreProc'],
\ 'border':   ['fg', 'Ignore'],
\ 'prompt':   ['fg', 'Conditional'],
\ 'pointer':  ['fg', 'Exception'],
\ 'marker':   ['fg', 'Keyword'],
\ 'spinner':  ['fg', 'Label'],
\ 'header':   ['fg', 'Comment'] }
