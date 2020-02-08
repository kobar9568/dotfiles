# dotfiles

## Noto

* Windows用セットアップスクリプト`Install.ps1`は実行前に以下の2つの操作が必要

1. PowerShellスクリプトの実行ポリシーを変更し、実行できるようにする
2. `gpedit.msc`から、一般ユーザーにシンボリックリンクの作成権限を与える

* Windowsでリポジトリをcloneする前に、gitの改行コード自動変換の設定を無効にしておく
* cloneしたら、`~/.gitconfig`は削除しておく
