"       ___                     ___          ___          ___
"      /\__\         ___       /\__\        /\  \        /\  \
"     /:/  /        /\  \     /::|  |      /::\  \      /::\  \
"    /:/  /         \:\  \   /:|:|  |     /:/\:\  \    /:/\:\  \
"   /:/__/  ___     /::\__\ /:/|:|__|__  /::\~\:\  \  /:/  \:\  \
"   |:|  | /\__\ __/:/\/__//:/ |::::\__\/:/\:\ \:\__\/:/__/ \:\__\
"   |:|  |/:/  //\/:/  /   \/__/~~/:/  /\/_|::\/:/  /\:\  \  \/__/
"   |:|__/:/  / \::/__/          /:/  /    |:|::/  /  \:\  \
"    \::::/__/   \:\__\         /:/  /     |:|\/__/    \:\  \
"     ~~~~        \/__/        /:/  /      |:|  |       \:\__\
"                              \/__/        \|__|        \/__/

" Required for line-continuation (\), %-motion, and most other modern
" vim behavior below — without it Vim runs in old vi-compatible mode.
set nocompatible

""""""""""""""""""""
" vim-plug (replaces NeoBundle, which is unmaintained)
" https://github.com/junegunn/vim-plug
""""""""""""""""""""
let s:plug_vim = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_vim))
  silent execute '!curl -fLo ' . s:plug_vim . ' --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'joshdick/onedark.vim'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File tree
Plug 'scrooloose/nerdtree'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Trailing whitespace highlight
Plug 'bronson/vim-trailing-whitespace'

" Motion
Plug 'easymotion/vim-easymotion'
Plug 'deris/vim-shot-f'
Plug 'rhysd/clever-f.vim'

" Auto-close brackets/quotes
Plug 'Townk/vim-autoclose'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Async lint engine (replaces syntastic, which is unmaintained)
Plug 'dense-analysis/ale'

" Indent guide
Plug 'Yggdroot/indentLine'

" Dash.app lookup (macOS only, no-op if Dash isn't installed)
Plug 'rizzatti/dash.vim'
Plug 'keith/investigate.vim'

" REPL integration
Plug 'jpalardy/vim-slime'

" ANSI-colored log file highlighting
Plug 'vim-scripts/AnsiEsc.vim'

" TypeScript syntax
Plug 'leafgarland/typescript-vim'

call plug#end()

""""""""""""""""""""
" Basic Setting
""""""""""""""""""""
let mapleader = "\<Space>"

set encoding=utf-8
filetype plugin indent on

" Not create swap file
set noswapfile

" Enable to see when scrolling
set scrolloff=5

" Use clipboard of OS (macOS pasteboard)
set clipboard=unnamed

" Show command in status row
set showcmd

" Indent
set autoindent
set smartindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Strong auto command
set wildmenu
set wildmode=list:full

" move to bracket
nnoremap [ %
nnoremap ] %

" autocompletion for brackets
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" move like emacs
imap <C-f> <Right>

" esc by c-j
imap <c-j> <esc>

" Replace only in command mode
nnoremap ; :
nnoremap : ;

" Line break without entering insert mode
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

" increment for alphabet
set nf=alpha

" edit vimrc asap
nnoremap <F5> :vsplit $MYVIMRC<CR>
" source right after editing vimrc
nnoremap <F4> :<C-u>source $MYVIMRC<CR>

" move as it looks
nnoremap j gj
xnoremap j gj
nnoremap k gk
xnoremap k gk
nnoremap gj j
xnoremap gj j
nnoremap gk k
xnoremap gk k

" select all lines
nnoremap g<C-a> ggVG

" not insert comment automatically
set formatoptions-=ro

" Run current file
autocmd BufNewFile,BufRead *.py nnoremap <Leader>s :!python3 %
autocmd BufNewFile,BufRead *.pl nnoremap <Leader>s :!perl %
autocmd BufNewFile,BufRead *.go nnoremap <Leader>s :!go run %

""""""""""""""""""""""""""""""
" Search Setting
""""""""""""""""""""""""""""""
set incsearch
set hlsearch
nnoremap <ESC><ESC> :nohlsearch<CR>

""""""""""""""""""""""""""""""
" NERDCommenter
""""""""""""""""""""""""""""""
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/ <Plug>NERDCommenterToggle
nmap <Leader>/a <Plug>NERDCommenterAppend

""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""
nnoremap <silent><C-e> :NERDTreeToggle<CR>
highlight SignColumn guibg=black
highlight SignColumn ctermbg=black
if !argc()
  autocmd vimenter * NERDTree|normal gg3j
endif

""""""""""""""""""""""""""""""
" Appearance
""""""""""""""""""""""""""""""
set number
set laststatus=2

let g:indentLine_color_term = 240
nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>

let g:airline#extensions#branch#enabled = 0
let g:airline_section_b =
      \ '%{airline#extensions#branch#get_head()}' .
      \ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}' .
      \ '%t%( %M%)'
let g:airline_section_c = ''
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

""""""""""""""""""""""""""""""
" Syntax
""""""""""""""""""""""""""""""
syntax enable
autocmd BufRead,BufNewFile *.erb set filetype=eruby.html
let python_highlight_all = 1
autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufRead,BufNewFile *.tsx set filetype=typescript

""""""""""""""""""""""""""""""
" Git
""""""""""""""""""""""""""""""
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>

""""""""""""""""""""""""""""""
" Investigate.vim (Dash lookup)
""""""""""""""""""""""""""""""
let g:investigate_use_dash = 1

silent! colorscheme onedark
