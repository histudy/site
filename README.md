# Himeji IT Study Meeting

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/) [![CircleCI](https://circleci.com/gh/histudy/site.svg?style=svg)](https://circleci.com/gh/histudy/site)

## テスト方法

1. サイトの生成に[Hugo](https://gohugo.io/)を利用しているのでインストールします。

    Linux: [リリースページ](https://github.com/gohugoio/hugo/releases)から最新のバイナリを `/usr/local/bin` に入れるのが簡単です。  
    
    Mac: Home Brewが使えます。
    ```shell
    brew install hugo
    ```
    
    Windows: [Chocolatey](https://chocolatey.org/)が使えます。
    ``` 
    choco install hugo -confirm
    ```


2. このリポジトリをクローンします。

    ```shell
    git clone https://github.com/histudy/site
    ```

3. HugoのWEBサーバーを起動します。

    ```shell
    hugo serve
    ```

4. ブラウザで [http://localhost:1313/](http://localhost:1313/) にアクセスするとサイトが表示されます。

## 各種コマンド

### Hugoサーバーを起動する

```shell
hugo serve
```

ブラウザで [http://localhost:1313/](http://localhost:1313/) にアクセスするとサイトが表示されます。

### ページを作成する

```shell
hugo new foo.md
```

`content/foo.md` ファイルが生成され、[http://localhost:1313/foo/]() に内容が表示されます。

### 勉強会の開催履歴ページを作成する

```shell
hugo new histudy/2021/07.md
```
`archetype` フォルダの `histudy.md` をテンプレートとして、`content/histudy/2021/07.md` が生成されます。  
加古川IT系インフラ勉強会も同様にテンプレートを用意しています。

## コンテンツフォルダの構成

```shell
content
├── _index.md  // トップページ https://histudy.jp/
├── about
│   ├── _index.md // Aboutページ /about/
│   └── beginning.md
├── histudy
│   ...
│   ├── 2018
│   ├── 2019
│   ├── 2021
│   │   └── 01.md // 履歴個別ページ /histudy/2021/01/
│   └── _index.md // 姫路IT系勉強会 開催履歴 一覧ページ /histudy/ 
├── images
├── kakogawa_infra
│   ...
│   ├── 2018
│   ├── 2019
│   │   └── 01.md
│   └── _index.md
├── news
│   ├── 20120717.md
│   ...
│   ├── 20170122.md
│   └── 20170221.md
├── organizememo
├── othermeetings
└── topic // トピック一覧ページ（従来の /blog/ ） /topic/
    ├── 20181203_redmine_advent_calendar.md   // トピック個別ページ
    └── 20181206_ansible_redmine_role.md
```
