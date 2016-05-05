set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'powerline/powerline'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'sjl/gundo.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'vimwiki/vimwiki'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax' 

" Python
Plugin 'nvie/vim-flake8'
Plugin 'rkulla/pydiction'
Plugin 'python-rope/rope'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'alfredodeza/pytest.vim'

" HTML
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Markdown
Plugin 'tpope/vim-markdown'

" Colorscheme
Plugin 'flazz/vim-colorschemes'

call vundle#end()            " required
filetype plugin indent on    " required


let maplocalleader = ","
set cryptmethod=blowfish2
syntax on                           " syntax highlighing

set foldmethod=indent
set foldnestmax=2
set foldlevel=99

" Ensure we don't get a swp file warning
set shortmess+=A

" Close scratch window after selection
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256;
endif

colorscheme wombat256i

set number
set incsearch
set hlsearch

" To convert tabs to spaces"
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set pastetoggle=<F9>
map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeWinSize=31

map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
nmap <leader>a <Esc>:Ack! --ignore-dir=migration
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>
inoremap jj <Esc>
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
nmap k gk
nmap j gj
vmap k gk
vmap j gj

" search  normally, hit cs replace the first match, then n.n.n.n to replace
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>


let $DJANGO_SETTINGS_MODULE='settings.test'

"pydiction
let g:pydiction_location = $HOME . '/.vim/bundle/pydiction/complete-dict' 

" Execute the tests
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
nmap <silent><Leader>tfv <Esc>:Pytest file verbose<CR>
nmap <silent><Leader>tcv <Esc>:Pytest class verbose<CR>
nmap <silent><Leader>tmv <Esc>:Pytest method verbose<CR>

" " cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>


" markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
nmap <leader>md :%! markdown --html4tags <cr>

" Ultisnips
let g:UltiSnipsListSnippets="<leader><tab>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" Systastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <F5> :SyntasticCheck<CR> :SyntasticToggleMode<CR>
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_java_checkers = ['javac']
let g:syntastic_java_checkers = ['tidy5']
let g:syntastic_check_on_open = 1

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType java set omnifunc=javacomplete#CompleteParamsInfo
autocmd FileType go set omnifunc=go#complete#Complete


set laststatus=2 "show the status line
set statusline=%-10.3n  "buffer number

nnoremap TT :TagbarToggle<CR>

" Virtualenv

let g:virtualenv_directory = $HOME ."/devel/virt_env/"


" reselect a block after indenting "
vnoremap < <gv
vnoremap > >gv

" ctrlp 
set wildignore+=*.pyc,*.pyo

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" Dates and Times
nnoremap <leader>time "=strftime("%Y-%m-%d %H:%M")<CR>P
inoremap <leader>time <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
nnoremap <leader>date "=strftime("%Y-%m-%d")<CR>P
inoremap <leader>date <C-R>=strftime("%Y-%m-%d")<CR>
nnoremap <leader>cob "=strftime("%Y-%m-%d 17:30")<CR>P
inoremap <leader>cob <C-R>=strftime("%Y-%m-%d 17:30")<CR>
nnoremap <leader>sob "=strftime("%Y-%m-%d 09:00")<CR>P
inoremap <leader>sob <C-R>=strftime("%Y-%m-%d 09:00")<CR>

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF


" 80 character width
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 80
     autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
     autocmd FileType python match Excess /\%80v.*/
     autocmd FileType python set nowrap
augroup END

" Don't save backups of *.gpg files
set backupskip+=*.gpg
" To avoid that parts of the file is saved to .viminfo when yanking or
" deleting, empty the 'viminfo' option.
set viminfo=

augroup encrypted
  au!
  " Disable swap files, and set binary file format before reading the file
  autocmd BufReadPre,FileReadPre *.gpg
    \ setlocal noswapfile bin
  " Decrypt the contents after reading the file, reset binary file format
  " and run any BufReadPost autocmds matching the file name without the .gpg
  " extension
  autocmd BufReadPost,FileReadPost *.gpg
    \ execute "'[,']!gpg --decrypt --default-recipient-self" |
    \ setlocal nobin |
    \ execute "doautocmd BufReadPost " . expand("%:r")
  " Set binary file format and encrypt the contents before writing the file
  autocmd BufWritePre,FileWritePre *.gpg
    \ setlocal bin |
    \ '[,']!gpg --encrypt --default-recipient-self
  " After writing the file, do an :undo to revert the encryption in the
  " buffer, and reset binary file format
  autocmd BufWritePost,FileWritePost *.gpg
    \ silent u |
    \ setlocal nobin
augroup END
