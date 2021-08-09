# dotfiles

![main](https://user-images.githubusercontent.com/38117745/109606294-ca416d00-7b69-11eb-84e1-fbc6b34edb1b.png)

## Memo

### Windowsでのclone

- Windowsでこのリポジトリをcloneする前に、gitの改行コード自動変換の設定を無効にしておくこと
- cloneしたら、`~/.gitconfig`は削除しておく
- もしくは、cloneしてインストール後に`$ git checkout .`を実行し、自動変換された改行コードを元に戻すこと

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
- coc-pyrightがNode.js 12以降に依存する

```
:CocInstall coc-eslint coc-fish coc-go coc-json coc-markdownlint coc-prettier coc-pyright coc-sh coc-yaml
```

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

## VSCode memo

### 拡張機能のCLIインストール

```
code --install-extension <extension-id[@version] | path-to-vsix>
```

### インストールメモ

```
code --install-extension GSGBen.fortigate-fortios-syntax
```
