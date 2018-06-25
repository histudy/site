# Himeji IT Study Meeting

[![Build Status](https://travis-ci.org/histudy/histudy.github.io.svg?branch=develop)](https://travis-ci.org/histudy/histudy.github.io)

## テスト方法

1. サイトの生成にHexoを利用しているので利用するためのパッケージをインストールします。

```shell
sudo apt install git nodejs nodejs-legacy npm
```

2. Hexoをインストールします。

```shell
sudo npm install -g hexo-cli
```

3. このリポジトリをクローンします。

```shell
git clone https://github.com/histudy/site
```

4. クローンしたリポジトリに必要なパッケージをインストールします。

``` shell
cd site/
npm install
```

5. ビルドしてHexoのサーバーを起動します。

```shell
hexo g
hexo s
```

6. ブラウザで http://localhost:4000/ にアクセスすると内容の確認ができます。

## 各種コマンド

### Hexoサーバーを起動する

```shell
npm run start
```

ブラウザで http://localhost:4000/ にアクセスすると内容の確認ができます。

### サイトを生成する

```shell
npm run generate
```

サイトが生成されます。

### デプロイ(Github Pageに反映する)

```shell
npm run deploy
```

## こんなときは

### hexoを実行しようとすると、「no method 'find'」というエラーが発生する

nodejsのバージョンが古いため、findメソッドが未実装のバージョンがインストールされている可能性があります。

```shell
nodejs -v
```

apt-getからは、古いバージョンのnodejsがインストールされてしまう可能性があるため、
v4以上をインストールしてください。

* v4をインストールする場合

```shell
sudo curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
```

* v6をインストールする場合

```shell
sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
```

* v10をインストールする場合

```shell
sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
```

## 検討課題

- テンプレートのカスタマイズとか
    - 現在は[hueman]を少し変更して使用中

[hueman]:https://github.com/ppoffice/hexo-theme-hueman
