set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set tabstop=4
set shiftwidth=4
set smarttab
set showmatch
set hlsearch
set incsearch
set ignorecase
colorscheme slate

set number 
set autoindent
set mouse=a
set softtabstop=4

noremap K     {
noremap J     }
noremap H     ^
noremap L     $

" noremap Л     {
" noremap О     }
" noremap Р     ^
" noremap Д     $

inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" set guifont=Monospace\ 20
" start
" autocmd TextChanged,TextChangedI <buffer> silent write
" set clipboard=unnamedplus

let g:XkbSwitchEnabled = 1
