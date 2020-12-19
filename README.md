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

### 2. インストールする

管理者権限のPowerShellで

```
# ./Install.ps1
```

## Vim memo

- vimのプラグインマネージャはvim-plugを使用
  - 初回起動時に本体とプラグインのインストールが行われる
- coc.nvimがNode.jsに依存する

- `:CocInstall coc-markdownlint`
- `:CocInstall coc-json`
- `:CocInstall coc-python`

### Setup coc-go

```
:CocInstall coc-go
```

- `coc-go`をインストール。

```
$ vim a.go
```

- .goファイルを最初に開いた際に初回セットアップが実行される。
  - `go`にパスが通っている必要がある。
  - `~/.config/coc/extensions/coc-go-data/bin/`に`gopls`がダウンロードされる。

以下の機能が動作しているかチェック

- `gopls`によるコード補完
- `CocAction('format')`による`gofmt`の実行
- importの自動解決

### Update Plugins

```
:PlugUpdate
```

- vim-plug管理下のプラグインをアップデートする。

```
:CocUpdate
```

- coc-nvim管理下のプラグインをアップデートする。

## Golang memo

```
$ go get golang.org/dl/goX.Y.Z
```

- `go get`に必要なので、初回は適当にGoのバイナリを用意しておく

```
$ goX.Y.Z download
```

- `~/sdk/`に一式降ってくる

```
$ ln -s $GOBIN/goX.Y.Z $GOBIN/go
```

- シンボリックリンク作成
