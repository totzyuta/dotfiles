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

" github completation in md
NeoBundle 'rhysd/github-complete.vim'

" Rails muscle
NeoBundle 'tpope/vim-rails'

" Ruby `end`
" Error: conflict with neocomplcache
"NeoBundle 'tpope/vim-endwise'

" highlight log file (which has ANSI data)
NeoBundle 'vim-scripts/AnsiEsc.vim'

" highlight space in the end of line
NeoBundle 'bronson/vim-trailing-whitespace'

" Red-Green-Refactor Cycle on Vim
" NeoBundle 'jodosha/vim-greenbar'
"
" moving easily
NeoBundle 'easymotion/vim-easymotion'


""""""""""""""""""""
" Basic Setting
""""""""""""""""""""
" change <Leader> key
let mapleader = "\<Space>"

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

"Show command in status row
set showcmd

"auto indent
set autoindent

"Keep space of indent
set smartindent

"Setting of TAB
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"Strong auto command
set wildmenu
"Show list
set wildmode=list:full

"move to brancket
nnoremap [ %
nnoremap ] %

"autocompletation for brankets
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" Auto Closing for Branckets and Quotations
NeoBundle 'Townk/vim-autoclose'

"move like emacs
imap <C-f> <Right>

" Replace only in command mode
nnoremap ; :
nnoremap : ;

" Line Break without entering insert mode
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

" easily commenting out
NeoBundle 'scrooloose/nerdcommenter'
" to change mapping keys
let g:NERDCreateDefaultMappings = 0
" insert a space after commenter
let NERDSpaceDelims = 1
" mappings
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/ <Plug>NERDCommenterToggle
nmap <Leader>/a <Plug>NERDCommenterAppend

" not insert comment automatically
set formatoptions-=ro

" extend f move
NeoBundle 'rhysd/clever-f.vim'

"Run Script on Vim
autocmd BufNewFile,BufRead *.rb nnoremap <Leader>s :!ruby %
autocmd BufNewFile,BufRead *.py nnoremap <Leader>s :!python %
autocmd BufNewFile,BufRead *.pl nnoremap <Leader>s :!perl %
autocmd BufNewFile,BufRead *.go nnoremap <Leader>s :!go run %
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" Search Setting
""""""""""""""""""""""""""""""
"Enable incremental search
set incsearch

"Hilight hidden by double ESC
nnoremap <ESC><ESC> :nohlsearch<CR>

"Enable hilight by search
set hlsearch
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" Libraries
""""""""""""""""""""""""""""""
" Emacs like key binding
NeoBundle 'jpalardy/vim-slime'

" Check syntacs error
NeoBundle 'scrooloose/syntastic'

" Check Ruby Style
NeoBundle 'ngmy/vim-rubocop'
nnoremap <Leader>r :RuboCop<CR>
"let g:vimrubocop_config = '~/dotfiles/vim/rubocop.yml'

" For great references
NeoBundle 'rizzatti/dash.vim'

" Benchmark for vimrc
NeoBundle 'mattn/benchvimrc-vim'

" Comment out easily by '\c'
NeoBundle "tyru/caw.vim.git"
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" Tree
NeoBundle 'scrooloose/nerdtree'
"ForNERDTree shortcut
nnoremap <silent><C-e> :NERDTreeToggle<CR>
highlight SignColumn guibg=black
highlight SignColumn ctermbg=black
"Launch NERDTree when without args
if !argc()
  autocmd vimenter * NERDTree|normal gg3j
endif
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" Appearance
""""""""""""""""""""""""""""""
"Show number of row
set number

" Gray Indent Line
NeoBundle 'Yggdroot/indentLine'
" let g:indentLine_faster = 1
let g:indentLine_color_term = 240
nmap <silent><Leader>i :<C-u>IndentLinesToggle<CR>

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
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" Hilight for Some Languages
""""""""""""""""""""""""""""""
"Enable Syntax hilight
syntax enable

"For Python syntacs hilight
let python_highlight_all = 1

" syntax highlight for slim
NeoBundle 'slim-template/vim-slim'
autocmd BufNewFile,BufRead *.slim set ft=slim

" syntax highlight for haml
NeoBundle 'tpope/vim-haml'
autocmd BufNewFile,BufRead *.haml set ft=haml

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
" Git Settings
""""""""""""""""""""""""""""""
"show diff of git while editing
NeoBundle 'akiomik/git-gutter-vim'
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" Challenging Stage
""""""""""""""""""""""""""""""
"Git tool for vim
NeoBundle 'tpope/vim-fugitive'

" TDD
map <leader>t :!greenbar bundle exec ruby<cr>
map <leader>te :!greenbar bundle exec rspec %<cr>
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" NeoBundle Ends
""""""""""""""""""""""""""""""
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
""""""""""""""""""""
