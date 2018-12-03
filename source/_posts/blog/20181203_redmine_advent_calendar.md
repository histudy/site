---
title: 姫路IT系勉強会におけるRedmineの運用事例
date: 2018-12-03
categories:
  - blog
tags:
  - 姫路IT系勉強会
  - 加古川IT系インフラ勉強会
---

# 姫路IT系勉強会におけるRedmineの運用事例

## はじめに

みなさん、はじめまして！

姫路IT系勉強会の [@223n](https://github.com/223n/) です。

この記事は、[Redmine Advent Calendar 2018](https://adventar.org/calendars/3352/)の４日目です。

今回は、姫路IT系勉強会で利用しているRedmineの運用事例について紹介したいと思います。

## 姫路IT系勉強会って？

**[姫路IT系勉強会](https://histudy.jp/)** は、兵庫県姫路市を中心とした周辺地域のIT系技術者、Webデザイナー、学生、それらの技術に興味を持つ人々が気軽に集まり交流できる勉強会です。

2012年から始まった勉強会は、参加者それぞれが「話を聞いてみたいこと」「話をしたいこと」を持ち寄って話をするという勉強会スタイルで毎月開催しています。

勉強会の開催以外にも、学生のIT系イベント参加に必要となる交通費や参加費の補助なども検討するなど、学生への支援も進めています。

「姫路IT系勉強会」のほかにも、インフラに特化した「加古川IT系インフラ勉強会」も毎月開催しています。

過去の勉強会で話をした内容などは、当日、[HackMD](https://hackmd.io/)を利用して参加者全員で作成したログを[勉強会のホームページ](https://hisutdy.jp/)で公開していますので、興味のある方は、ぜひ一度ご参加ください！

開催案内は、[Connpass](https://histudy.connpass.com/)や[TwitterのBotアカウント](https://twitter.com/himeji_study/)で案内していますので、こちらをご確認ください。

## Redmineでやっていること

Redmineでは、勉強会で発生した要望やタスクを管理しています。

恐らく、一般的な利用方法だと思います。

![チケットの一覧例](/images/20181203/001_ticket_list.png)

※注記：「トラッカー」を「チケット種別」に変更するなど、一部文言を変更するなどの変更を加えています。後述参照。

## 基本的な構成（トラッカーとステータス、ワークフロー）

基本的な構成として、トラッカー、ステータス、ワークフローがあげられます。

### トラッカー

トラッカーは、以下の５個を作成しています。

| トラッカー | 説明 |
|:-:|---|
| 要望 | 具体的なことが未定であったり提案などを含む場合に設定します。<br />具体的に内容が決まったら各チケット種別に割り振ります。 |
| 不具合 | 既存の不具合などに設定します。 |
| タスク | 新規や追加対応が必要な場合に設定します。 |
| 運用保守 | 定例対応やサーバ保守などの運用保守の範囲内で<br />対応する場合に設定します。 |
| その他 | いずれにも該当しない場合に設定します。 |

### ステータス

各チケットのステータスは、以下の８個を作成しています。

| ステータス | 説明 | 完了済み |
|:-:|---|:-:|
| 未対応 | 何も対応が行われていない場合に設定します。<br />チケット起票時のデフォルトのステータスです。 |　× |
| 対応中 | 対応を行っている場合に設定します。 | × |
| 対応済み | 対応作業が完了しておりテスト中または確認中の場合に設定します。 | × |
| 確認待ち | 確認してほしい担当者や依頼者の確認待ちの場合に設定します。 | × |
| フィードバック | 確認してほしい担当者による確認の結果、元の担当者に振り戻す場合に設定します。<br />例えば、「対応漏れ」「不具合報告」「改善提案」などです。 | × |
| 経過観察中 | 本番環境で正常に動作しているか経過観察中の場合に設定します。 | × |
| 完了 | すべての対応が完了した場合に設定します。 | ○ |
| 破棄 | 対応が必要なかった場合に設定します。 | ○ |

具体的な遷移例としては、次図のように遷移します。

![ステータスの遷移例](/images/20181203/005_status_changes.png)

### ワークフロー

例えば、「要望」のチケットの場合には、以下のようなワークフローを設定しています。

![要望チケットのワークフロー](/images/20181203/006_workflow.png)

このワークフローで気をつけなければならないのが、 **「 ステータスが確認待ちのまま、元の担当者に振り戻されてしまう 」** ことです。

別の担当者から見ると、<br />**「 別の担当者 から、 元の担当者 に、 確認を求める 」**<br />となるのですが、チケットの起票者から見ると<br />**「 確認をお願いしたことが、自分に戻ってきた 」**<br />ことになってしまうため、注意が必要になります。

## 運用面の改善など

### チケットのテンプレート化

Redmineの導入初期につまずきやすい点として、チケットに記載される項目や内容がチケットを作成する人によって異なってしまう（統一されない）という問題があげられます。

その問題を解決するため、勉強会では[Redmine Issue Templates plugin](https://github.com/akiko-pusu/redmine_issue_templates/)というプラグインを導入しています。

このプラグインでは、トラッカーに応じて事前にテンプレート（ひな形）を作成できるため、勉強会ではタスクや要望などに合わせたテンプレートを作成しています。

チケットのテンプレートをあらかじめ作成しておくことで、誰でもチケットの作成に必要な項目が埋まった状態で作成することができ、項目を考えることなく穴埋め方式でチケットを作成することができるようになります。

![新しいチケットの作成ページ](/images/20181203/003_new_ticket.png)

### Slack連携とやりとりの記録

Redmineでのチケット作成や編集などは、[Redmine Slack](https://github.com/cat-in-136/redmine-slack)というプラグインを導入することで、勉強会のSlackに通知を流すようにしています。

※注記：導入しているのは本家からフォークされたリポジトリですが、Wiki更新時の通知に差分確認用のURLが付与されるようになっていることや「ニュース」や「フォーラム」の更新の通知にも対応しているなどの機能強化されてるため、こちらを利用しています。

ただ、この際に注意していることとして、 **Slack上でチケットの内容について直接やりとりを進める** のではなく、 **チケットの注記にコメントを入力する** ことで、チケットの履歴に残すように運用しています。

もし、Slackでやりとりをした結果からチケットを作成する場合や、Slack上でやりとりを行ってしまった場合でも、その内容をRedmineに引用するようにしています。

そうすることで、別の担当者や時間が経った後にRedmineのチケットを見返した際、履歴を見ただけで当時のやりとりの流れが分かるようになります。

![Slackのサンプル](/images/20181203/008_slack_sample.png)

![チケットのサンプル](/images/20181203/007_ticket_sample.png)

### PlantUMLなどによる図形のテキスト化

その他にも、[PlantUML plugin for Redmine](https://github.com/dkd/plantuml/)や[Redmine Drawio plugin](https://github.com/mikitex70/redmine_drawio/)といったプラグインも導入しています。

これらのプライグインでは、テキストによって状況遷移図やフローチャートなどを描画したり、添付したテキストファイルから図を描画することができます。

そのため、勉強会の運用フローをフローチャートでまとめる場合などに、画像をペイントなどで編集して都度添付し直して更新するのではなく、テキストを編集するだけで簡単にプレビューで確認しながら更新することができ、かつテキストなので差分も取得ができるなどのメリットが多くあります。

### 微調整

勉強会では、構築時にja.ymlファイルを書き換えることで、例えば「トラッカー」を「チケット種別」に変えるなどの一部文言の変更を行っています。

https://github.com/redmine/redmine/blob/master/config/locales/ja.yml

また、表示のスタイルを変更することである程度見やすくなりますが、どうしても一部使いづらい部分や微調整したい部分が出てきてしまいます。

そのような微調整を行うため、[View Customize plugin](https://github.com/onozaty/redmine-view-customize/)というプラグインを導入しています。

例えば、チケットを作成・編集する際の説明欄の高さを大きくしたり、ヘッダー部分のフォントサイズを大きくする、といった微調整をこのプラグインで実現しています。

このプラグインを使うことでは見た目の調整以外にも、例えばユーザーごとにログイン後の初期ページの変更する、といったことも実現しています。

### やってみせるという最初のステップ

当初、これらの改善を考案したメンバーは、これらの運用を他のメンバーには説明していませんでした。

上記の改善を考案したメンバーが、実際にRedmineの運用をやってみせてから他のメンバーに説明することで、他のメンバーは運用のイメージがしやくすなり、他のメンバーがやりやすい環境が生まれるので運用の浸透が進み、説明を聞いていないメンバーも自然と運用に参加しやすい環境に向かっていけたのだと思います。

改善を考案したメンバーが言うには、「[やってみせ、言って聞かせて、させてみせ、ほめてやらねば、人は動かじ](https://www.compass-point.jp/kakugen/4676/)」ということらしいです。

## その他

最後に、勉強会が[GitHub](https://github.com/histudy/)で公開しているRedmine関連のリポジトリについて、少し紹介させていただきます。

### vagrant-redmine

[vagrant-redmine](https://github.com/histudy/vagrant-redmine)では、Redmineのデモ環境を構築することができるvagrantのソースを公開しています。

Redmineのテーマやプラグインを試してみたい、新しいバージョンを触ってみたいなどのちょっとしたことをやってみたい方には便利ではないでしょうか？

私も、プラグインを作っている際のテストに試すなどといったことに利用しています。

### ansible-role-redmine

また、[ansible-role-redmine](https://github.com/histudy/ansible-role-redmine)では、Redmineをansibleで構築するためのロールを公開しています。

先のvagrant-redmineでも使われているのですが、設定はもちろんのこと、言語ファイルのカスタマイズやステータス、トラッカー、ワークフローなどの初期設定も行うことができます。

手作業での構築が面倒な方などには便利ではないでしょうか？