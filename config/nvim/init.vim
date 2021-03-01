call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

set termguicolors
set number
set smartindent
set nocompatible
set hidden
syntax on
set cursorline
if has('mouse')
	set mouse=nv
endif

set background=light
let g:gruvbox_italic=1
colorscheme gruvbox

" indentation
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set formatoptions+=r
set nomodeline

" persistent undo
set undofile
set undodir=~/.local/share/nvim/undo/
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au BufRead,BufNewFile SConstruct set filetype=python

" load files at last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" automatically install missing plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" airline
set noshowmode
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1

" markdown
let g:mkdp_auto_start = 1

" custom keys
noremap bn :bn<CR>
noremap bp :bp<CR>
noremap bd :bd<CR>
noremap tn :tabn<CR>
noremap tp :tabp<CR>
noremap <C-t> :tabnew<CR>
noremap <C-p> :Files<CR>
