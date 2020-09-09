" ファイル系の動作
"
" バックアップファイルを作成しない
set nobackup
" スワップファイルを作成しない
set noswapfile
" viminfoファイルを作成しない
set viminfo=

" 保存系の動作
"
" 改行で終わらないファイルを編集した際に、改行を付加しない
set nofixeol

" ファイルに変更が加わった際に自動で読み込む
set autoread
" よくわからないけどとりあえず書いとけ
set hidden

" UI系の動作
"
" シンタックスハイライトを有効化
syntax enable
" 行番号を表示する
set number
" 入力中のコマンドを右下に表示する
set showcmd
" ウインドウタイトルにファイル名を反映させる
set title
" コマンド表示行を2行にする
set cmdheight=2

" ステータスラインの設定
"
" ステータスラインを常時表示
set laststatus=2
" ステータスラインにファイルパスを表示
set statusline=%F
" ステータスラインに編集状態を表示
set statusline+=%m
" ステータスラインに書込権限を表示
set statusline+=%r
" ステータスラインにヘルプページ状態を表示
set statusline+=%h
" ステータスラインにプレビュー状態を表示
set statusline+=%w
" ステータスラインの以降の情報を右寄せにする
set statusline+=%=
" ステータスラインにカーソル位置を表示
set statusline+=Ln\ %l,\ Col\ %02v
" ステータスラインにファイルエンコーディングを表示
set statusline+=\ %{&fenc!=''?&fenc:&enc}
" ステータスラインに改行コードを表示
set statusline+=\ %{&ff}
" ステータスラインにファイルタイプを表示
set statusline+=\ %Y

" エディタ系の動作
"
" よくわからないけどとりあえず書いとけ
set virtualedit=onemore
" 自動インデント:C言語風
set smartindent
" 自動インデントの幅?
set shiftwidth=4
" ハードタブの表示幅
set tabstop=4
" ハードタブを可視化
set list listchars=tab:->
" ソフトタブを使う
set expandtab
" ビープ音を可視化?
set visualbell
" 閉じ括弧入力時に対応する括弧にカーソルを飛ばす
set showmatch
" showmatchで復帰する時間の設定 100ms単位
set matchtime=1

" キーのマッピング変更 nmapではなくnnoremapを使うべき
"
" ラップされた仮想的な行に移動できるようにする
nnoremap j gj
nnoremap k gk

" Exit insert mode with 'jj'.
imap jj <Esc>

" Always display signcolumn.
set signcolumn=yes

" 甘えるな
let sermon='甘えるな'
nnoremap <Up>    :echo sermon<CR>
nnoremap <Down>  :echo sermon<CR>
nnoremap <Left>  :echo sermon<CR>
nnoremap <Right> :echo sermon<CR>
"inoremap <Up>    <Esc>:echo sermon<CR>i
"inoremap <Down>  <Esc>:echo sermon<CR>i
"inoremap <Left>  <Esc>:echo sermon<CR>i
"inoremap <Right> <Esc>:echo sermon<CR>i

" よくわかんないの
"
" よくわからないけどとりあえず書いとけ
set wildmode=list:longest

" Automatically install vim-plug.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug
call plug#begin('~/.vim/plugged')
" vim-plugins
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" color schenes
Plug 'sainnhe/sonokai'
call plug#end()

" NERDTree configs
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" coc.vim
function! s:check_back_space() abort
  let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

noremap <C-f> :call CocAction('format')<CR>
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Enable true color.
if has('termguicolors')
  set termguicolors
endif

" Set color scheme.
let g:sonokai_style = 'default'
colorscheme sonokai

" tmux用の追加設定
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
