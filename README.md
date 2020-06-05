# dotfiles

## Memo

* Windowsでリポジトリをcloneする前に、gitの改行コード自動変換の設定を無効にしておく
* cloneしたら、`~/.gitconfig`は削除しておく

## Installation (Windows)

### 1. PowerShellスクリプトの実行を許可する

管理者権限のPowerShellを立ち上げて、スクリプトの実行を許可
引数は`-ArgumentList`内stringに追加

```
# powershell -NoProfile -ExecutionPolicy ByPass -Command `
"Start-Process powershell.exe -ArgumentList \"-ExecutionPolicy ByPass\"-Verb runas"
```

### 2. 一般ユーザーにシンボリックリンクの作成権限を与える

`gpedit.msc`から、一般ユーザーにシンボリックリンクの作成権限を与える
