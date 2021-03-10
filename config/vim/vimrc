"                   _
"           _   __ (_)____ ___   _____ _____
"          | | / // // __ `__ \ / ___// ___/
"          | |/ // // / / / / // /   / /__
"          |___//_//_/ /_/ /_//_/    \___/


"--------------------------------------------------------------"
"         base settings                                        "
"--------------------------------------------------------------"
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,sjis,cp932,euc-jp
set ttyfast
set splitright
set splitbelow
set backspace=indent,eol,start
set shiftwidth=4
set tabstop=4
set softtabstop=0
set hidden
set virtualedit=onemore
set hlsearch
set incsearch
set ignorecase
set smartcase
set nobackup
set noswapfile
set helplang=ja,en
set ruler
set number
set ttimeoutlen=10
set gcr=a:blinkon0
set scrolloff=3
set laststatus=2
set modeline
set modelines=10
set wildmenu
set clipboard=unnamed
set title
set titleold="Terminal"
set titlestring=%F
set cursorline
set autoindent
set autoread
set mouse=a
set whichwrap=h,l
filetype on
syntax on


"--------------------------------------------------------------"
"         indent                                               "
"--------------------------------------------------------------"
augroup fileTypeIndent
  autocmd!
  autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType eruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType javascriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType typescriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType sh setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType markdown setlocal wrap
augroup END


"--------------------------------------------------------------"
"         key binds                                            "
"--------------------------------------------------------------"
" prefix
let mapleader="\<Space>"

" htkn -> hjkl
nnoremap h h
vnoremap h h
nnoremap t j
vnoremap t j
nnoremap k k
vnoremap k k
nnoremap n l
vnoremap n l

" scroll
nnoremap ok <C-u>
nnoremap ot <C-d>

" window
nnoremap <Leader>s :<C-u>split<CR>
nnoremap <Leader>v :<C-u>vsplit<CR>
noremap <UP> <C-w>k
noremap <Down> <C-w>j
noremap <Left> <C-w>h
noremap <Right> <C-w>l

" tab
nnoremap <Leader>tab :tabnew<CR>

" terminal
nnoremap <Leader>ter :vertical terminal<CR>

" move buffer
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>

" copy / delete
nnoremap <Leader>yy :%y<CR>
nnoremap <Leader>dd :%d<CR>

" increment / decrement
nnoremap + <C-a>
nnoremap - <C-x>

" edge of line
nnoremap N $
vnoremap N $
nnoremap H 0
vnoremap H 0

" search
nnoremap /  /\v
nnoremap K N
nnoremap T n

" absorb type
command! -nargs=0 W :w
command! -nargs=0 Q :q


"--------------------------------------------------------------"
"         dein.vim                                             "
"--------------------------------------------------------------"
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = fnamemodify(expand('<sfile>'), ':h').'/plugin/dein.toml'
  let s:lazy_toml = fnamemodify(expand('<sfile>'), ':h').'/plugin/dein_lazy.toml'

   " load toml files
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" install plugins
if dein#check_install()
  call dein#install()
endif
