"Timings
set updatetime=100

"Clipboard
set clipboard+=unnamedplus

"UI
set hidden
set number                   " show line number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace

"Tabs and spaces
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

"Searching
set incsearch       " search as characters are entered
set hlsearch        " highlight matche
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
                    " case-sensitive otherwise

"Plugins
call plug#begin()
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neomake/neomake'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'iliastsa/souffle.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tomlion/vim-solidity'
Plug 'dylon/vim-antlr'
call plug#end()
"Colorscheme
set termguicolors
set background=dark
colorscheme NeoSolarized

"Vim airline
set laststatus=2
set ttimeoutlen=50 
let g:airline_theme = 'solarized' 
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"Neomake
function! MyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elsif has('unix')
    return readfile('/sys/class/power_supply/ADP0/online') == ['0']
  endif
  return 0
endfunction

if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nw', 1000)
endif

let g:neomake_python_enabled_markers = []
let g:neomake_python_exe = '/bin/python3'

"Nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

"UltiSnips
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

"YouCompleteMe
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's

" Folding
set foldenable
set foldlevelstart=10  " default folding level when buffer is opened
set foldnestmax=10     " maximum nested fold
set foldmethod=syntax  " fold based on indentation

"Keymaps and bindings
let mapleader=","   " leader is comma

" edit/reload vimrc
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

" better ESC
inoremap jj <esc>

" fast save and close
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>q :q<CR>

" insert blank line before current line without leaving insert mode
imap <leader>o <c-o><s-o>

" fix indentation
nnoremap <leader>i mzgg=G`z<CR>

" turn off search highlights
nnoremap <leader><space> :nohlsearch<CR>

" split navigation
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

" buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

" ctags
nnoremap <leader>. :CtrlPTag<cr>
