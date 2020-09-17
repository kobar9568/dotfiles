# dotfiles

## Memo

- Windowsでリポジトリをcloneする前に、gitの改行コード自動変換の設定を無効にしておく
- cloneしたら、`~/.gitconfig`は削除しておく

## Installation (Linux)

```
$ ./install.sh
```

## Installation (Windows)

### 1. PowerShellスクリプトの実行を許可する

管理者権限のPowerShellを上げて、以下を実行

```
# Set-ExecutionPolicy Bypass
```

### 2. 一般ユーザーにシンボリックリンクの作成権限を与える

`gpedit.msc`から、一般ユーザーにシンボリックリンクの作成権限を与える

## Vim memo

- vimのプラグインマネージャはvim-plugを使用
  - 初回起動時に本体とプラグインのインストールが行われる
- coc.nvimがNode.jsに依存する

- `:CocInstall coc-markdownlint`
- `:CocInstall coc-json`
- `:CocInstall coc-python`

### Update Plugins

```
:PlugUpdate
```

- vim-plug管理下のプラグインをアップデートする。

```
:CocUpdate
```

- coc-nvim管理下のプラグインをアップデートする。

### Setup coc-go

```
$ go get golang.org/x/tools/gopls
```

- `gopls`をインストール。

```
:CocInstall coc-go
```

- `coc-go`をインストール。

```
$ vim a.go
```

- .goファイルを最初に開いた際に初回セットアップが実行される。

- `gopls`によるコード補完
- `CocAction('format')`による`gofmt`の実行
- importの自動解決
