---
title: AnsibleでRedmineを設置するロールを作ったお話
date: 2018-12-06
categories:
  - blog
tags:
  - 姫路IT系勉強会
  - 加古川IT系インフラ勉強会
---

# AnsibleでRedmineを設置するロールを作ったお話

みなさん、こんにちは。

この記事は、[Redmine Advent Calendar 2018](https://adventar.org/calendars/3352/)と[Ansible Advent Calendar 2018](https://qiita.com/advent-calendar/2018/ansible/)の６日目です。

今回は、[姫路IT系勉強会](https://histudy.jp/)がGitHubで公開している[ansible-role-redmine](https://github.com/histudy/ansible-role-redmine/)について、どうしてこのようなものを作ったのかなどをお話したいと思います。

## 姫路IT系勉強会って？

**[姫路IT系勉強会](https://histudy.jp/)** は、兵庫県姫路市を中心とした周辺地域のIT系技術者、Webデザイナー、学生、それらの技術に興味を持つ人々が気軽に集まり交流できる勉強会です。

2012年から始まった勉強会は、参加者それぞれが「話を聞いてみたいこと」「話をしたいこと」を持ち寄って話をするという勉強会スタイルで毎月開催しています。

勉強会の開催以外にも、学生のIT系イベント参加に必要となる交通費や参加費の補助なども検討するなど、学生への支援も進めています。

「姫路IT系勉強会」のほかにも、インフラに特化した「加古川IT系インフラ勉強会」も毎月開催しています。

過去の勉強会で話をした内容などは、当日、[HackMD](https://hackmd.io/)を利用して参加者全員で作成したログを[勉強会のホームページ](https://hisutdy.jp/)で公開していますので、興味のある方は、ぜひ一度ご参加ください！

開催案内は、[Connpass](https://histudy.connpass.com/)や[TwitterのBotアカウント](https://twitter.com/himeji_study/)で案内していますので、こちらをご確認ください。

## ansible-role-redmineって？

[ansible-role-redmine](https://github.com/histudy/ansible-role-redmine/)は、[ansible](https://www.ansible.com/)でRedmineのインストール、セットアップができるロールです。

このロールを応用したものとして、[vagrant-redmine](https://github.com/histudy/vagrant-redmine)という[Vagrant](https://www.vagrantup.com/)を使って簡単にRedmineの環境を作ることができるものも公開しています。

※注記：このロールの動作環境は **Debian限定** です。

## なぜ作ったの？

一言で言うと、 **「以下のようなケースに対応したいのでRedmineをサクッと設置できるようにしたい！（切実）」**

* このプラグインって動くの？
* このテーマって、どんな感じになるの？
* この設定を変更して、どんな感じになるの？

## 最初は、先人の作ったものを探してみる

なかなか思い通りのものがありませんでした。

最終的には、以下にたどり着き、実装方法を読み解いていきました。

* [GitHub - y503unavailable/redmine-centos-ansible](https://github.com/y503unavailable/redmine-centos-ansible/)
  * [実際に見たコードは、この辺です](https://github.com/y503unavailable/redmine-centos-ansible/blob/3.4-unofficialcooking/roles/redmine/tasks/main.yml)

Ansibleのロール（役割）として見た場合に、プラグインやテーマのインストールも単一のロールでカバーできるようにしておきたいと考えました。

※テーマやプラグインとしてロールを分けることも考慮しましたが、細切れになりすぎてメンテナンス性が悪くなりそうだったため、やめました。

さらに試行錯誤を繰り返しながら、自分なりの設計に落とし込んでいくと、以下のような要件に落ち着きました。

* RedmineのソースコードをGitHubから取得してインストールできる
  * 更新対応しやすいようにする
* Redmineのデータベースも同時に作成して初期設定が行われる
* プラグインやテーマも同時にインストールできる

要件はまとまりましたので、「さぁ、書くか！」ということで、先に見つけたロールを参考にしつつ、自分なりの書き方で試行錯誤を繰り返しながら実装を行いました。

そして、できあがったロールを使ってRedmineを設置してみると、驚くほど簡単に設置することができるようになりました。

しかし、いざデモ環境を設置してみると、違和感に気付きました。

## 違和感

以前から違和感は感じていましたが、以前はRedmineの設置自体がそれなりにハードルが高く、仕方が無いで済ませていましたが、設置が簡単にできてしまうと「Redmine自体の日本語の表記」が気になり始めました。

日本語の表記のうち、例を挙げるとすれば、Redmineを導入しようとした場合に必ず聞かれることとして多い「トラッカーって何？」という問題です。

※このトラッカーという表記が分かりにくいという件に関しては、TwitterでぼやいたところRedmineのガチ勢に補足され、既に本家の方にチケットが切られています。（[Patch #29045: Change Japanese translation for Tracker - Redmine](http://www.redmine.org/issues/29045)）

その他にも、直感的に何の機能か分からない部分（例えば、メインメニューに表示されている「文書」や「ニュース」など）が色々と出てきます。

Redmineのソースコードを見ると、i18はいたって単純なので、言語設定のファイルを書き換えてあげれば、比較的簡単に変更することができることが分かりました。

[GitHub - redmine/redmine - /config/locales/ja.yml](https://github.com/redmine/redmine/blob/master/config/locales/ja.yml)

そこで、Ansibleの変数を別途用意しておき、Redmine本体の言語ファイルと統合することで上書きしてしまうという力技を思いつきました。

実際の書き換え処理は、以下のようになっています。

[GitHub - histudy/ansible-role-redmine - /tasks/customize_lang.yml](https://github.com/histudy/ansible-role-redmine/blob/master/tasks/customize_lang.yml)

※最後の処理は、Ansibleのgitモジュールを利用してGitHubからRedmineのソースを取得しているため、次回実行時にAnsibleのgitモジュールでソース更新が失敗してしまいますので、書き換えた内容を検知しないようにしています。

※参考資料：[Qiita - usamik26 - 既にgit管理しているファイルをあえて無視したい](https://qiita.com/usamik26/items/56d0d3ba7a1300625f92)

実際の設定例は、以下のようになります。

[GitHub - histudy/ansible-role-redmine - redmine_customize_language](https://github.com/histudy/ansible-role-redmine#redmine_customize_language)

これで、Redmineの言語ファイルを書き換えて、自分の好みに合うようにカスタマイズすることができるようになりました。

## その他の機能

Redmineの運用にあたり、運用開始時に挙げられる点として、「ブラウザを開いてチケットを登録するのがめんどくさい問題」などもあります。

※実際に出先などでチケットを登録したいと思っても、Redmineにログインしてチケット登録するのは・・と、ロールを作った本人も思っています。

幸いにして、Redmineにはメールでチケットを登録する機能が標準で実装されています。

* [Redmine - メールによるチケット登録](http://guide.redmine.jp/RedmineReceivingEmails/)

用意されている全てのケースに対応するのは不可能なので、比較的対応しやすい以下の２つに限定して対応することにしました。

* IMAPサーバからの取得
* POP3サーバからの取得

※ [さくらのメールボックス](https://www.sakura.ne.jp/mail/)などを利用すれば、普通の人でも簡単に専用のメールアドレスガ発行できるため

これらの設定であれば、サーバ側で定期的にRedmineのメールによるチケット登録処理を実行するように設定することで、出先などからでもチケット登録用にメールアドレスにメールを送るだけでチケット登録ができるようになります。

### 「IMAPサーバからの取得」の設定例

[GitHub - histudy/ansible-role-redmine - redmine_receive_imap_cron_job](https://github.com/histudy/ansible-role-redmine#redmine_receive_imap_cron_job)

### 「POP3サーバからの取得」の設定例

[GitHub - histudy/ansible-role-redmine - redmine_receive_pop3_cron_job](https://github.com/histudy/ansible-role-redmine#redmine_receive_pop3_cron_job)

※Redmineの設置が簡単にできたとしても、ここら辺の設定を手動で設定しなければならないというのは、Ansible ~~狂信者~~ 教信者の作者としては耐えがたいものがあり、Redmineのロールとしては不十分だと思っています。

※また、SSHでログインして手動で設定すると負けだと思う。

## 人間の欲とは恐ろしいもので・・・

これで、Redmineに関しては一通りロールでカバーできるようになりました。

しかし、**人間の欲** というものは恐ろしいもので、

Redmineをサクッと構築できるようになったのはいいけれど、簡単に設置できるものだから、デモ環境を何度も作っては消すという作業を繰り返しているうちに、毎回、Redmineを手動で設定をすることがとても面倒だという事実に直面しました。

そういえば、最初に参考にさせて貰ったロールには、Redmineの設定を流し込む処理が書いてあったということを思い出しました。

以前のロールを詳しく見ていくと、 `rails console` や `rails runner` を実行して、Redmineの設定を流し込んでいるということが分かりました。

それを元に考えると、「設定用のAnsibleの変数を別途定義しておき、それを元に設定をRedmineに流し込むRubyのコードを生成して `rails console` で取り込めばいけるよね」という力技に出ることに。

具体的には、Ansibleのtemplateモジュールを使い、Ansibleの変数をYAML形式のヒアドキュメントとして出力し、それを流し込む処理のテンプレートを作成しました。

あとは、Ansibleのtemplateモジュールを利用してサーバ上にRubyのコードを流し込み、コマンドモジュールで `rails console` を呼び出す形で実装しました。

※最終的には、Ansibleの処理としては以下のようになりました。

### 設定の流し込み処理

[GitHub - histudy/ansible-role-redmine - /tasks/main.yml](https://github.com/histudy/ansible-role-redmine/blob/master/tasks/main.yml#L135-L147)

### テンプレートファイル

* [大元のテンプレートファイル](https://github.com/histudy/ansible-role-redmine/blob/master/templates/settings.rb.j2)
* [トラッカーの流し込み処理部](https://github.com/histudy/ansible-role-redmine/blob/master/templates/settings/tracker.rb.j2)

※Rubyの経験が浅いので、コードが汚いのは突っ込まないでほしいです。

※Rubyのコードの書き方が気になりますが、「とりあえずは、やりたいことができればいい！」ということで自分を納得させました。

## このロールを作るためにやった作業

実際の流し込み処理を理解するために、Redmineのソースコード（コントローラやモデル周り）を読みあさりました。

* [コントローラ](https://github.com/redmine/redmine/tree/master/app/controllers)
* [モデル](https://github.com/redmine/redmine/tree/master/app/models)

Redmineのデータベース構造を把握するために、デモ構築のデータベースをリバースエンジニアリングして、各テーブルとモデルの状態を把握しました。

## このロールを作る際に苦労した点

Ruby歴が浅いので、言語シンタックスに慣れませんでした。

Ansibleのテンプレートを作る際に、脳内で複数の言語シンタックスを考えながら、最終的に生成されたRubyコードの挙動を脳内でトレースするのが、とても大変でした。

## 書いた人

* [姫路IT軽勉強会](https://histudy.jp/)
  * @wate ([Twitter](https://twitter.com/aWebprogrammer/)/[GitHub](https://github.com/wate/))
  * @223n ([GitHub](https://github.com/223n/))
