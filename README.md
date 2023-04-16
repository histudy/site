Himeji IT Study Meeting
===========================

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/) [![CircleCI](https://circleci.com/gh/histudy/site.svg?style=svg)](https://circleci.com/gh/histudy/site)

コンテンツフォルダの構成
--------------------------

```txt
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

開催ログの追加方法
-------------

Redmineの以下のWikiを参照してください。

[開催ログの追加方法](https://redmine.histudy.jp/projects/official-site/wiki/%E9%96%8B%E5%82%AC%E3%83%AD%E3%82%B0%E3%81%AE%E8%BF%BD%E5%8A%A0%E6%96%B9%E6%B3%95)

### 簡易手順書

1. dev containersを起動する
2. 勉強会のログを取得する
   * 「メモ」の「勉強会のログを取得する」を参照
3. 取得したログをVSCodeで確認する
4. 「ドキュメントのフォーマット」を適用し整形する
5. 自動正規しきれないものは手動で整形する
6. 表示内容などに誤りがないか確認する
7. ログの内容をコミットする
8. コミットエラーが出た場合はエラーの内容を確認し必要に応じて修正する
    * pre-commitによりMarkdownlintおよびtextlintの自動整形がかかります
    * 自動整形により変更が発生した場合はコミットエラー扱いになります

メモ
---------------

### 勉強会のログを取得する

必要な環境変数を設定し、以下のコマンドを実行する。

```sh
ansible-playbook automations/add_meeting_log.yml
```
