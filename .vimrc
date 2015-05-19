""""""""""""""""""""
" NeoBundle 
""""""""""""""""""""
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
 if &compatible
   set nocompatible               " Be iMproved
 endif

 " Required:
 set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
""""""""""""""""""""


""""""""""""""""""""
" Basic Setting for Vim
""""""""""""""""""""
"Enable Syntax hilight
syntax enable

"Show number of row
set number

" Encoding utf-8
set encoding=utf-8

" Auto detecting file types off 
" and turn on in the end of this file
filetype off
filetype plugin indent off

"emphasize current row
"set cursorline

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
nnoremap <ESC><ESC> :nohlsearch<CR>

"Keep space of indent
set smartindent

"Settingof tab
set tabstop=2
set shiftwidth=2
set expandtab

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

nnoremap ; :
nnoremap : ;

" increment for alphabet
set nf=alpha

"Run Script on Vim
autocmd BufNewFile,BufRead *.rb nnoremap <C-p> :!ruby %
autocmd BufNewFile,BufRead *.py nnoremap <C-p> :!python %
autocmd BufNewFile,BufRead *.pl nnoremap <C-p> :!perl %
""""""""""""""""""""


""""""""""""""""""""""""""""""
" Hilight for Some Languages
""""""""""""""""""""""""""""""
"For Python syntacs hilight
let python_highlight_all = 1

" syntacs hilight for slim
NeoBundle 'slim-template/vim-slim'
autocmd BufNewFile,BufRead *.slim set ft=slim

" Syntacs highlighting for CoffeeScript
NeoBundle 'kchmck/vim-coffee-script'
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee

" hilight for yaml
NeoBundle 'chase/vim-ansible-yaml'

"Hilight SQL
let php_sql_query = 1

"Hilight HTML
let php_htmlInStrings = 1

"Hilight for Scala
NeoBundle "derekwyatt/vim-scala"
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" Libraries
""""""""""""""""""""""""""""""
" Emacs like key binding 
NeoBundle 'jpalardy/vim-slime'

" Check syntacs error
NeoBundle 'scrooloose/syntastic'

" Auto Closing for Branckets and Quotations
NeoBundle 'Townk/vim-autoclose'

" For great references
NeoBundle 'rizzatti/dash.vim'

"Benchmark for vimrc
NeoBundle 'mattn/benchvimrc-vim'

" Comment out easily by '\c'
NeoBundle "tyru/caw.vim.git"
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" Customized status line
set laststatus=2
NeoBundle 'bling/vim-airline'
  let g:airline#extensions#branch#enabled = 0
  let g:airline_section_b =
        \ '%{airline#extensions#branch#get_head()}' .
        \ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}' .
        \ '%t%( %M%)'
  let g:airline_section_c = ''
  let g:airline_theme='bubblegum'
  let g:airline#extensions#whitespace#enabled = 0

" Tree 
NeoBundle 'scrooloose/nerdtree'
"ForNERDTree shortcut
nnoremap <silent><C-e> :NERDTreeToggle<CR>
highlight SignColumn guibg=black
highlight SignColumn ctermbg=black
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" neocomplcache for auto completing
""""""""""""""""""""""""""""""
NeoBundle 'Shougo/neocomplcache'
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" key-mappings for auto complement
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" 補完候補が表示されている場合は確定。そうでない場合は改行
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" Challenging Stage
""""""""""""""""""""""""""""""
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_faster = 1
let g:indentLine_color_term = 240
nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>

"Git tool for vim
NeoBundle 'tpope/vim-fugitive'

"show diff of git while editing
NeoBundle 'akiomik/git-gutter-vim'
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
""""""""""""""""""""""""""""""


" Auto detecting file type
filetype plugin indent on
