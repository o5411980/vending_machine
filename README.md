# vending_machine

自動販売機ワーク　の　リポジトリ
masterブランチとdevelopブランチを作成し、両方に8/13日のstep5完成時のコードをpushしました。<br>
リファクタリングは、別ブランチにpushしてプルリク(PullRequest)を出す。グループで確認してからプルリクをMergeしてdevelopブランチへ反映。<br>
<br>
このリポジトリへのpushコマンド；<br>
  % git push git@github.com:o5411980/vending_machine.git ローカルブランチ名<br>
    ※ ローカルブランチ名 ; 開発を行った各自のローカルのブランチ名<br>
  % github上でプルリクを作成する時に、比較対象としてdevelopブランチを選択(※デフォルトで選択されている)。<br>
<br>
次の担当は、前担当のプルリクがMergeした後、リモートのdevelopブランチをローカルにプル(またはクローン)。<br>
  % git pull git@github.com:o5411980/vending_machine.git develop<br>
これで最新のdevelopブランチがローカル上にできる。そこから新しくローカルの作業用ブランチ(仮にissues/#6とする）を分岐。<br>
  % git branch<br>
  % git checkout -b issues/#6<br>
これで分岐したissues/#6ブランチが作成されて移動するので、issues/#6ブランチでリファクタリング作業。<br>
リファクタリングできたら、ローカルのissues/#6ブランチでaddとcommit。
  % git add -A
  % git commit -m "コミットメッセージを入力"
その後、上のpushのところに戻る。その場合は、ローカルブランチ名 = issues/#6 として push。<br>


・test.rb ; ワークで一緒に作成しているファイル。このファイルを編集。


・step5.rb ; ワークで一緒に作成した8/13日時点のファイル
・sample.rb ; ステップ3 までの参考コード <br>
・test-sample1.rb,  test-sample2.rb ; ステップ4までの参考コード <br>
・test-sample3.rb ; ステップ5までの参考コード
