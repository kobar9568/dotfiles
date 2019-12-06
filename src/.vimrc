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
" ステータスラインを常時表示
set laststatus=2
" 入力中のコマンドを右下に表示する
set showcmd
" ウインドウタイトルにファイル名を反映させる
set title

" よくわからないけどとりあえず書いとけ
set virtualedit=onemore
" 自動インデント:C言語風
set smartindent
" 自動インデントの幅?
set shiftwidth=4
" ハードタブの表示幅
set tabstop=4
" ソフトタブを使う
set expandtab
" ハードタブを可視化
set list listchars=tab:\\t
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
