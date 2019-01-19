call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete-clangx'
call plug#end()

set number
syntax on
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
set noshowmode
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

autocmd FileType yaml let b:did_indent = 1
au BufRead,BufNewFile SConstruct set filetype=python

" deoplete
let g:deoplete#enable_at_startup = 1

" nerdtree
map <C-e> :NERDTreeToggle<CR>
" start automatically if no file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" start automatically if directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close if only nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
