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
