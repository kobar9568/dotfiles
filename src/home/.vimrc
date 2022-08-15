" Define behavior of external files.
"
set nobackup
set noswapfile
set viminfo=

" Define behavior of save file.
"
set nofixeol

" Define behavior of load file.
"
set autoread
set hidden

" Define Newline code.
"
if has('win32')
  set encoding=utf-8
  set fileformat=unix
  edit ++fileformat=unix
endif

" Define UI behavior.
"
syntax enable
set number
set showcmd
set title
let &titlestring = 'Vim'
set cmdheight=2
set showtabline=2
set signcolumn=yes
set splitbelow
set splitright

" statusline configs.
"
set laststatus=2
set statusline=%F
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=%=
set statusline+=Ln\ %l,\ Col\ %02v
set statusline+=\ %{&fenc!=''?&fenc:&enc}
set statusline+=\ %{&ff}
set statusline+=\ %Y

" Define editor behavior.
"
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set list listchars=tab:->,trail:-
set showmatch
set matchtime=1
set visualbell
set backspace=2

" Define system behavior.
"
set updatetime=250
set ttimeoutlen=0
set wildmode=list:longest

" Define registers behavior.
"
if has('win32')
  set clipboard=unnamed
endif

" Define keymappings.
"
let mapleader = "\<Space>"

noremap  <Up>    <Nop>
noremap  <Down>  <Nop>
noremap  <Left>  <Nop>
noremap  <Right> <Nop>
noremap  <Del>   <Nop>

inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
inoremap <Del>   <Nop>

nnoremap <Leader><C-f> :vim "" **/* \| cw<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
inoremap jj <Esc>

nmap <Leader>d <Plug>AirlineSelectPrevTab
nmap <Leader>f <Plug>AirlineSelectNextTab
nnoremap <Leader>x :bp<bar>sp<bar>bn<bar>bd<CR>

" Turn off paste mode when leaving INSERT mode.
autocmd InsertLeave * set nopaste

" Set Shell for Windows.
"
if has('win32')
  set shell=PowerShell\ -ExecutionPolicy\ Bypass\ -NoLogo
endif

" Automatically install vim-plug.
"
if has('unix')
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
elseif has('win32')
  if empty(glob($HOME . '/vimfiles/autoload/plug.vim'))
    silent execute('!curl -fLo ' . $HOME . '/vimfiles/autoload/plug.vim --create-dirs '
      \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

" Plugins
"
if has('unix')
  call plug#begin('~/.vim/plugged')
  " vim-plugins
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-surround'
  Plug 'Townk/vim-autoclose'
  Plug 'dag/vim-fish'
  Plug 'sheerun/vim-polyglot'
  Plug 'kobar9568/vim-fortios'
  Plug 'google/vim-searchindex'
  " color schenes
  Plug 'sainnhe/sonokai'
  call plug#end()
elseif has('win32')
  call plug#begin($HOME . '/vimfiles/plugged')
  " vim-plugins
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-surround'
  Plug 'Townk/vim-autoclose'
  Plug 'dag/vim-fish'
  Plug 'sheerun/vim-polyglot'
  Plug 'kobar9568/vim-fortios'
  Plug 'google/vim-searchindex'
  Plug 'github/copilot.vim'
  " color schenes
  Plug 'sainnhe/sonokai'
  call plug#end()
endif

" NERDTree configs
"
nnoremap <C-e> :NERDTreeToggle<CR>

" coc.vim configs
"
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <C-f> :silent call CocAction('runCommand', 'editor.action.organizeImport')<CR>:call CocAction('format')<CR>
nnoremap <C-d> :call CocAction('jumpDefinition')<CR>

" Enable true color.
"
if has('termguicolors')
  set termguicolors
endif

" Set color scheme.
"
let g:sonokai_style = 'default'
colorscheme sonokai

" Set terminal color.
"
" The colors normally are:
"  0   black
"  1   dark red
"  2   dark green
"  3   brown
"  4   dark blue
"  5   dark magenta
"  6   dark cyan
"  7   light grey
"  8   dark grey
"  9   red
" 10   green
" 11   yellow
" 12   blue
" 13   magenta
" 14   cyan
" 15   white
"
" Hyper
let g:terminal_ansi_colors = [
  \ "#000000",
  \ "#C51E14",
  \ "#1DC121",
  \ "#C7C329",
  \ "#0A2FC4",
  \ "#C839C5",
  \ "#20C5C6",
  \ "#C7C7C7",
  \ "#686868",
  \ "#FD6F6B",
  \ "#67F86F",
  \ "#FFFA72",
  \ "#6A76FB",
  \ "#FD7CFC",
  \ "#68FDFE",
  \ "#FFFFFF"
  \ ]

" Set Vim-specific sequences for RGB colors
"
if has('unix')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Fix background color renders for Windows Terminal.
"
if has('win32')
  set t_ut=""
endif

" vim-airline configs
"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'
