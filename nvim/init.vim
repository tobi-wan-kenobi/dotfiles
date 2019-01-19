call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
call plug#end()

set number
set noshowmode
set cursorline
if has('mouse')
	set mouse=nv
endif

" colorscheme
set termguicolors
set background=light
let g:gruvbox_italic=1
colorscheme gruvbox

" indentation
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set formatoptions+=r

" persistent undo
set undofile
set undodir=~/.local/share/nvim/undo/
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif

" airline
let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'

autocmd FileType yaml let b:did_indent = 1
au BufRead,BufNewFile SConstruct set filetype=python
