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
set t_Co=16
if $TERM == "xterm-256color"
  set t_Co=256
endif
set background=light
colorscheme solarized

" status bar
set laststatus=2
set showtabline=2

autocmd FileType yaml let b:did_indent = 1
au BufRead,BufNewFile SConstruct set filetype=python
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

nmap <F8> :TagbarToggle<CR>
