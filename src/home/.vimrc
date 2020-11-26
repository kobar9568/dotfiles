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

" Define UI behavior.
"
syntax enable
set number
set showcmd
set title
set cmdheight=2
set showtabline=2
set signcolumn=yes

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
set list listchars=tab:->
set showmatch
set matchtime=1
set visualbell

" Define system behavior.
"
set updatetime=250
set ttimeoutlen=0
set wildmode=list:longest

" Define keymappings.
"
let mapleader = "\<Space>"

map  <Up>    <Nop>
imap <Up>    <Nop>
map  <Down>  <Nop>
imap <Down>  <Nop>
map  <Left>  <Nop>
imap <Left>  <Nop>
map  <Right> <Nop>
imap <Right> <Nop>

imap jj <Esc>
nnoremap j gj
nnoremap k gk

nmap <Leader>d <Plug>AirlineSelectPrevTab
nmap <Leader>f <Plug>AirlineSelectNextTab
nnoremap <Leader>x :bp<bar>sp<bar>bn<bar>bd<CR>

" Turn off paste mode when leaving INSERT mode.
autocmd InsertLeave * set nopaste

" Automatically install vim-plug.
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
"
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
" color schenes
Plug 'sainnhe/sonokai'
call plug#end()

" NERDTree configs
"
nnoremap <C-e> :NERDTreeToggle<CR>

" coc.vim configs
"
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <C-f> :call CocAction('format')<CR>
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

" Set Vim-specific sequences for RGB colors
"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" vim-airline configs
"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='papercolor'
