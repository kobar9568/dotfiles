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

" Define behavior of search.
"
set hlsearch
" TODO: Migrate to <Leader>j
nnoremap <ESC><ESC> :nohlsearch<CR>
" Alt + J to nohlsearch.
nnoremap <M-j> :nohlsearch<CR>

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

cnoremap <Up>    <Nop>
cnoremap <Down>  <Nop>
cnoremap <Left>  <Nop>
cnoremap <Right> <Nop>
cnoremap <Del>   <Nop>

nnoremap <Leader><C-f> :vim "" **/* \| cw<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
inoremap jj <Esc>

nmap <Leader>d <Plug>AirlineSelectPrevTab
nmap <Leader>f <Plug>AirlineSelectNextTab
nnoremap <Leader>x :bp<bar>sp<bar>bn<bar>bd<CR>

" Alt+K to enter command mode history.
nnoremap <M-k> :<Up>
" Use HJKL in command mode.
cnoremap <M-h> <Left>
cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-l> <Right>
" Use X to delete in command mode.
cnoremap <M-x> <Del>
" Use jj to enter command window.
cnoremap jj <C-f>

" Accept suggestions when pressing Alt + L in terminal mode.
" Workaround for a keycode problem.
tnoremap <M-l> <Right>

" Turn off paste mode when leaving INSERT mode.
autocmd InsertLeave * set nopaste

" Autosave session when leaving the Vim.
autocmd VimLeave * mks! ~/Session.vim

" Set Shell for Windows.
"
if has('win32')
  set shell=powershell.exe\ -ExecutionPolicy\ Bypass\ -NoLogo
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
  Plug 'retorillo/md5.vim'
  Plug 's3rvac/vim-syntax-yara'
  " color schenes
  Plug 'sainnhe/sonokai'
  call plug#end()
endif

" NERDTree configs
"
nnoremap <C-e> :NERDTreeToggle<CR>

" coc.vim configs
"
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Select completion via Ctrl + J & Ctrl + K.
inoremap <silent><expr> <C-j>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make Ctrl + L to accept selected completion.
inoremap <silent><expr> <C-l> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Custmized keybinds for coc.
nnoremap <C-f> :silent call CocAction('runCommand', 'editor.action.organizeImport')<CR>:call CocAction('format')<CR>
nnoremap <C-d> :call CocAction('jumpDefinition')<CR>

" Trigger isort on save. (Maybe duplicating with black.)
autocmd BufWritePre *.py silent! :call CocAction('runCommand', 'python.sortImports')

" ROT13 function
"
function ROT13(plaintext)
  let ciphertext = ''
  for i in range(len(a:plaintext))
    let ascii = char2nr(a:plaintext[i])
    if ascii >= 65 && ascii <= 77 || ascii >= 97 && ascii <= 109
      let ciphertext .= nr2char(ascii + 13)
    elseif ascii >= 78 && ascii <= 90 || ascii >= 110 && ascii <= 122
      let ciphertext .= nr2char(ascii - 13)
    else
      let ciphertext .= nr2char(ascii)
    endif
  endfor
  return ciphertext
endfunction
command -narg=1 ROT13 echomsg ROT13('<args>')

" Enable true color.
"
if has('termguicolors')
  set termguicolors
endif

" Set color scheme.
"
let g:sonokai_style = 'default'
colorscheme sonokai
" Workaround for rendering issue in Windows Terminal.
highlight Comment cterm=NONE

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

" Snippets for command mode.
" For VR
" /id (Yank Broadcast ID.)
execute ROT13('paberznc vq [0-9N-Sn-s]\{32}<Ragre>')
" :vr (Prepare to replace {Broadcast ID} to ID.)
execute ROT13('paberznc <fvyrag> ie %f/vaqrk_/uggcf:\/\/ibq-fgernz\.aux\.wc\/enqvbbaqrznaq\/e\/6A87YWY8MZ\/f\/fgernz_6A87YWY8MZ_{Oebnqpnfg VQ}\/vaqrk_<Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Yrsg><Qry><Qry><Qry><Qry><Qry><Qry><Qry><Qry><Qry><Qry><Qry><Qry><Qry><Qry><Yrsg><P-s>:frgs grkg<Ragre>')
" Usage: /id -> ygn -> :vr -> p -> Enter

" Memo on key bindings for beginner. :)
"
" <C-w> | (Pipe)         ... Set width of current window to maximum.
" <C-w> > (Greater-than) ... Increase width of current window.
" <C-w> < (Less-than)    ... Decrease width of current window.
"
" <C-w> <S-n>            ... Change to normal mode in terminal window.
"
" q [Macro name]         ... Start recording macro.
" q                      ... Stop recording macro.
" @ [Macro name]         ... Play macro.
