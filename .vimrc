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
"set smartindent
filetype plugin indent on
set tabstop=4
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
set t_Co=16
set background=dark
colorscheme solarized
hi SignColumn guibg=#002b36 ctermbg=8

" status bar
set laststatus=2
set showtabline=2

" airline
let g:airline_powerline_fonts = 1 
let g:airline#extensions#tabline#enabled = 1

" keyboard shortcuts
nmap <F8> :TagbarToggle<CR>
nmap <F9> :SignatureToggle<CR>
nmap <C-u> :GundoToggle<CR>

autocmd FileType yaml let b:did_indent = 1
