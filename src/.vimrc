" ファイル系の動作
"
" バックアップファイルを作成しない
set nobackup
" スワップファイルを作成しない
set noswapfile
" viminfoファイルを作成しない
set viminfo=

" ファイルに変更が加わった際に自動で読み込む
set autoread
" よくわからないけどとりあえず書いとけ
set hidden

" UI系の動作
" 入力中のコマンドを右下に表示する
set showcmd
" シンタックスハイライトを有効化
syntax enable
" 行番号を表示する
set number
" ステータスラインを常時表示
set laststatus=2

" よくわからないけどとりあえず書いとけ
set virtualedit=onemore
" 自動インデント:C言語風
set smartindent
" ビープ音を可視化?
set visualbell

" 閉じ括弧入力時に対応する括弧にカーソルを飛ばす
set showmatch
" showmatchで復帰する時間の設定 100ms単位
set matchtime=1

" よくわからないけどとりあえず書いとけ
set wildmode=list:longest

" キーのマッピング変更 nmapではなくnnoremapを使うべき
"
" ラップされた仮想的な行に移動できるようにする
nnoremap j gj
nnoremap k gk

set list listchars=tab:\\t
set expandtab
set tabstop=4
set shiftwidth=4
set nofixeol
