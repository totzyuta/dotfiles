"vi = Vim
set nocompatible
"Enable Syntax hilight
syntax enable
"Show number of row
set number
filetype off
set helpfile=$VIMRUNTIME/doc/help.txt
filetype on
filetype plugin indent on
"Check file type
filetype plugin on
"emphasize current row
"set cursorline
"set information on status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 
"Not create swap file
set noswapfile
"Enable to see when scrolling
set scrolloff=5
"Use clipboard of OS
set clipboard+=unnamed
set clipboard=unnamed
"Enable incremental search
set incsearch
"Show command in status row
set showcmd
"auto indent
set autoindent
"Hilight hidden by double ESC
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"Keep space of indent
set smartindent
"Settingof tab
set tabstop=2
set shiftwidth=2
set expandtab
"indent depended on file type
filetype indent on
"Strong auto command
set wildmenu
"Show list
set wildmode=list:full
"Enable hilight by search
set hlsearch
"move to brancket
nnoremap [ %
nnoremap ] %
"move like emacs
imap <C-f> <Right>
"auto complement of brankets

"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"vnoremap { "zdi{<C-R>z}<ESC>
"vnoremap [ "zdi[<C-R>z]<ESC>
"vnoremap ( "zdi(<C-R>z)<ESC>
"vnoremap " "zdi"<C-R>z"<ESC>
"vnoremap ' "zdi'<C-R>z'<ESC>

nnoremap ; :
nnoremap : ;

" increment for alphabet
set nf=alpha

"FOR PHP
"Check grammar by :make
au FileType php setlocal makeprg=php\ -|\ %
au FileType php setlocal errorformat=$m\ in\ %f\ on\ line\ %|
"Hilight SQL
let php_sql_query = 1
"Hilight HTML
let php_htmlInStrings = 1

"FOR Ruby
"Check grammar by :make
au FileType ruby setlocal makeprg=ruby\ -c\ %
au FileType ruby setlocal errorformat=%\ in\ %f\ on\ line\ %|

"Vundle Plugin
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Dash Shorcut
Plugin 'rizzatti/dash.vim'
call vundle#end()

"Comment
NeoBundle "tyru/caw.vim.git"
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)
