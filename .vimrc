" find pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

syntax on

set number
set scrolloff=10
set wildmode=longest,list
set noshowmode
set nocompatible
set cursorline

set noerrorbells
set novisualbell

" indentation
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set formatoptions+=r

" search
set incsearch
set hls

" do not select line numbers when doing text-select via mouse
if has('mouse')
	set mouse=nv
endif

" persistent undo
set undofile
set undodir=~/.vim/undo
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif

" colorscheme
set termguicolors
set background=light
let g:gruvbox_italic=1
colorscheme gruvbox

" status bar
set laststatus=2
set showtabline=2

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

autocmd FileType yaml let b:did_indent = 1
au BufRead,BufNewFile SConstruct set filetype=python
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

nmap <F8> :TagbarToggle<CR>
