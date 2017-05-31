" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"Relative line numbering
set relativenumber
set number

"Misc. spacing configs
set expandtab
set tabstop=4
set shiftwidth=4
set scrolloff=3 "3 lines below and above cursor
set encoding=utf-8

" Vundle configuration

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()

filetype plugin indent on

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"NERDTree
map <F10> :NERDTreeToggle<CR>


"Vim airline
set laststatus=2
set ttimeoutlen=50 
let g:airline_theme = 'solarized' 
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts = 1

"Vim theme
syntax on
set background=dark
set t_Co=256
colorscheme solarized

"YouCompleteMe
"let g:ycm_register_as_syntastic_checker = 1
"let g:ycm_enable_diagnostic_signs = 1
"let g:ycm_always_populate_location_list = 1
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_autoclose_preview_window_after_insertion = 1
