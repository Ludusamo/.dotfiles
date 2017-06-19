" Usual Configurations
set nocompatible

hello

syntax enable
filetype plugin on

set path+=**
set wildmenu

set relativenumber
set nu
set tabstop=4
set shiftwidth=4
set colorcolumn=80

colorscheme slate

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Leader mappings
let mapleader = " "
nnoremap <Leader>tn :tabnew<CR>
nnoremap <leader>l :set list!<CR>
nnoremap <leader>zz m`:TrimSpaces<CR>``

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
