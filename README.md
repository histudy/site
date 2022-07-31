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
