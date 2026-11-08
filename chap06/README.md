# 第6回：Gitブランチ実習（生成AIでポートフォリオサイトを作り比べる）

## この回で学ぶこと
この回では，Gitの「ブランチ」機能について学びます．
ブランチを使うと，いまある作業に影響を与えずに別の案を試したり，複数の作業を並行して進めたりできます．

題材は，第5回で書いた `PROFILE.md` です．
生成AI（ChatGPT・Claude・Gemini・Copilot など好きなもの）に `PROFILE.md` を渡して，HTMLのポートフォリオサイトを作ってもらいます．
ただし，作るのは1つではありません．**2種類のデザインを，それぞれ別のブランチで**作って比べます．
気に入ったほうは，**次回（第7回）**に GitHub へ `git push` して，`https://あなたのユーザー名.github.io/` として世界に公開します．
今日は，その準備として，自分のパソコンの中で2つのデザインを作り比べるところまで行います．

### 今日のゴール
- [ ] 第6回の資料がある `main-06` ブランチに移動し，自分の `PROFILE.md` を `main-05` ブランチから持ってくる
- [ ] `main-06` から `design-a` と `design-b` の2つのブランチを作り，それぞれに生成AIで作ったサイトをコミットする
- [ ] `git switch` でブランチを切り替えると，ブラウザに表示されるサイトが入れ替わることを確かめる
- [ ] `git log --graph` で，履歴が枝分かれしていることを確かめる
- [ ] `.git/refs/heads` と `.git/HEAD` をのぞいて，ブランチの正体を知る
- [ ] 演習課題（コマンドの出力結果）を提出する

### 事前に用意するもの
- 第5回で書いてコミットした `PROFILE.md`
- 生成AIのチャットサービス（ログインしておく）

## ブランチとは？
ブランチとは，日本語で「枝」という意味です．
木の幹から枝が分かれるように，あるコミットから，別の作業の流れを分岐させることができます．

### なぜブランチを使うの？
Webサイトのデザインを2案作って比べたいとき，ブランチを知らないと，こうなりがちです．

```
index.html
index_v2.html
index_v2_最終.html
index_v2_最終_本当に最終.html
```

ブランチを使えば，**ファイル名は `index.html` のまま**，案ごとに別の「枝」に保存しておけます．

- **安全に試せる**：元の状態は一切変わらない
- **並行して進められる**：A案とB案を，いつでも行ったり来たりできる
- **捨てやすい**：うまくいかなかった案は，枝ごと捨てればいい

### 今日作る枝
```
              +-- design-a
              |
  main-06 ----+
              |
              +-- design-b
```

- `main-06`：第6回の資料に，あなたの `PROFILE.md` を持ってきたもの（準備で作ります）
- `design-a`：`PROFILE.md` の「サイトのイメージ」どおりのデザイン
- `design-b`：まったく違う雰囲気のデザイン

## 実習の流れ
1. 準備：第6回の資料がある `main-06` ブランチに移動し，自分の `PROFILE.md` を `main-05` から持ってくる
2. 実習1：`design-a` と `design-b` の2つのブランチで，生成AIにサイトを作ってもらう
3. 実習2：ブランチを切り替えて，サイトが入れ替わるのを見る．枝分かれを可視化する
4. 実習3：ブランチの正体（`.git/refs/heads` と `.git/HEAD`）をのぞく
5. 演習課題：コマンドの出力結果を提出する

それでは，順番に進めていきましょう．

---

## 0. 準備：main-06 に移動して，自分の PROFILE.md を持ってくる

### 0-1. リポジトリのいちばん上のフォルダに移動する
ターミナルを開き，第5回でクローンした `oss-practice-2026` フォルダに移動します．
（第5回の終わりに `chap05` フォルダにいた人は，`cd ..` で1つ上に戻ります）

```bash
pwd
```

表示の最後が `oss-practice-2026` になっていればOKです．

> 今日は，**ずっとこのフォルダ（`oss-practice-2026`）にいたまま**作業します．`cd chap06` などはしません．

### 0-2. いまのブランチと，コミットし忘れを確認する
```bash
git branch
```

`* main-05` と表示されればOKです．

```bash
git status
```

`nothing to commit, working tree clean` と表示されれば，次に進んでください．

`modified: chap05/PROFILE.md` と表示された場合は，コミットし忘れた変更があります．先に保存しておきましょう：
```bash
git add chap05/PROFILE.md
```
```bash
git commit -m "プロフィールを更新"
```

### 0-3. GitHubから，最新のブランチを取ってくる
```bash
git fetch origin
```

表示例：
```
From https://github.com/tomohitoy/oss-practice-2026
 * [new branch]      main-06    -> origin/main-06
```

`[new branch] main-06` の行は，「GitHubに新しく `main-06` ブランチがあったので取ってきた」という意味です．
`git fetch` は，GitHubにある最新のブランチを**取ってくるだけ**のコマンドです．あなたのファイルやブランチは書きかわりません．

> よく似たコマンドに `git pull` があります．こちらは「取ってくる（fetch）」に加えて，「いまのブランチに取りこむ」ところまで一気に行います．
> 今日は取ってくるだけでよいので，`git fetch` を使います．

### 0-4. main-06 ブランチに移動する
```bash
git switch main-06
```

表示例：
```
Switched to a new branch 'main-06'
branch 'main-06' set up to track 'origin/main-06'.
```

今日の資料が入っている `chap06` フォルダを確認しましょう．

```bash
ls chap06
```

表示例：
```
README.md  template
```

### 0-5. あれ？自分のプロフィールがない？
`PROFILE.md` の中身を見てみましょう．

```bash
cat chap05/PROFILE.md
```

第5回で書いたはずの自己紹介がなく，何も書かれていない元の状態に戻っています．

これは，**`main-06` が，第6回の資料を配るためのブランチ**だからです．
`main-06` は，第5回の資料のコミット（`d6e7885`）から枝を伸ばして，第6回の資料を追加したブランチです．
一方，あなたの自己紹介のコミットは，同じ `d6e7885` から伸びた **`main-05` という別の枝**にあります．

```
              +-- main-05 : あなたのコミット（基本情報を追加，趣味などを追加）
              |
  d6e7885 ----+
              |
              +-- main-06 : 第6回の資料のコミット（第六回の講義資料をアップロード など）
```

**ブランチが違えば，ファイルの中身も違う**のです．

> 消えてしまったわけではありません．あなたの自己紹介は，`main-05` ブランチにちゃんと残っています．

### 0-6. main-05 から PROFILE.md を持ってくる
まず，ブランチを切り替えずに，`main-05` にある `PROFILE.md` をのぞいてみます．

```bash
git show main-05:chap05/PROFILE.md
```

`ブランチ名:ファイルの場所` と書くと，**そのブランチにあるファイルの中身**を表示できます．
自分の自己紹介が表示されたら，`main-05` からこのファイルを持ってきます．

```bash
git restore --source=main-05 chap05/PROFILE.md
```

**コマンドの意味**：
- `git restore`：ファイルを，ある時点の状態に戻すコマンド
- `--source=main-05`：「`main-05` ブランチにある状態」を使う
- `chap05/PROFILE.md`：書きかえるファイル

もう一度中身を確認して，自分の自己紹介になっていればOKです．

```bash
cat chap05/PROFILE.md
```

`git status` で確認すると，`PROFILE.md` が変更されたことになっています．

```bash
git status
```

表示例：
```
On branch main-06
Your branch is up to date with 'origin/main-06'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   chap05/PROFILE.md
```

この変更をコミットします．

```bash
git add chap05/PROFILE.md
```
```bash
git commit -m "第5回のプロフィールを main-05 から持ってくる"
```

これで準備完了です．
あなたの `main-06` に，**第6回の資料**と**あなたの自己紹介**がそろいました．

---

## 実習1：2つのデザインを，2つのブランチで作る

### 1-A. `design-a` ブランチを作る

#### 1. ブランチを作成する
```bash
git branch design-a
```

このコマンドで `design-a` という名前のブランチが作られます．
**まだ移動はしていません．**

#### 2. ブランチの一覧を確認する
```bash
git branch
```

表示例：
```
  design-a
  main-05
* main-06
```

`*` がついているのが「いまいるブランチ」です．まだ `main-06` にいることがわかります．

#### 3. 作成したブランチに移動する
```bash
git switch design-a
```

`Switched to branch 'design-a'` と表示されればOKです．

**ポイント**：`git switch` は，ブランチを切り替えるコマンドです．

もう一度確認してみましょう：
```bash
git branch
```

`* design-a` のように，`design-a` に `*` が移っていれば成功です．

### 1-B. 生成AIにサイト（デザインA）を作ってもらう

> 生成AIが使えない場合は，このあとの「[1-D. 生成AIが使えないときは](#1-d-生成aiが使えないときは)」を見てください．

#### 1. サイトを保存するファイルを作る
```bash
touch chap06/index.html
```

`chap06` フォルダの中に，空の `index.html` ができました．
`index.html` は，Webサイトを開いたときに最初に表示されるページの名前です．

#### 2. 生成AIへの依頼文（プロンプト）をコピーする
[`chap06/template/prompt.txt`](./template/prompt.txt) に，生成AIへの依頼文が入っています．
VS Code などのエディタで開いて，中身をすべてコピーします．
（GitHubのページで開いた場合は，右上のコピーボタン（Copy raw file）でもコピーできます）

> **`template` フォルダの中のファイルは書きかえずに，コピーして使ってください．**
> 書きかえてしまうと，その変更がコミットに紛れこんでしまいます．

#### 3. 生成AIに依頼する
1. 生成AIのチャットを開き，コピーした依頼文を貼り付けます（まだ送信しません）
2. エディタで `chap05/PROFILE.md` を開き，中身をすべてコピーします
3. 依頼文のいちばん下の「【自己紹介】」の次の行に，`PROFILE.md` の中身を貼り付けて送信します

依頼文には，次のような条件が書いてあります．どんな条件でAIに頼んでいるか，読んでおきましょう．
- HTMLファイル1つで完結させる（CSSもファイルの中に書く）
- 画像ファイルと JavaScript は使わない
- 【自己紹介】に書かれていないことを付け足さない
- デザインの雰囲気は，`PROFILE.md` の「サイトのイメージ」に合わせる

#### 4. 返ってきたコードを `index.html` に保存する
1. AIの回答のコードブロックにある「コピー」ボタンで，コードをコピーします
2. エディタで `chap06/index.html` を開き，貼り付けて保存します
3. ファイルが `<!DOCTYPE html>` で始まり，`</html>` で終わっていることを確認します

> AIの回答の前後にある説明文（「以下がコードです」など）は，コピーしないでください．

#### 5. ブラウザで表示する
Macの場合：
```bash
open chap06/index.html
```

Windows（Git Bash）の場合：
```bash
start chap06/index.html
```

うまく開かない場合は，エクスプローラー（Finder）で `oss-practice-2026` → `chap06` → `index.html` をダブルクリックしてください．

**このブラウザのタブは閉じずに残しておきましょう．** 実習2で使います．

#### 6. 公開してよい内容か確認する（重要）
このサイトは，次回インターネットに公開します．次の点を必ず確認しましょう．

- [ ] `PROFILE.md` に書いていないこと（経歴・資格・受賞歴など）を，AIが勝手に付け足していない
- [ ] 本名のフルネーム・学籍番号・住所・電話番号・メールアドレスなど，公開したくない情報が入っていない
- [ ] 文字化けしていない

直したいところがあれば，AIに「〇〇の部分を削除して，もう一度全体を出力して」と頼み直すか，エディタで直接書きかえて保存しましょう．

> 生成AIは，事実ではないことをもっともらしく書くことがあります（**ハルシネーション**）．
> AIが作ったものでも，**公開する責任はあなたにあります**．

#### 7. 変更をステージング＆コミットする
```bash
git status
```

表示例：
```
On branch design-a
Untracked files:
  (use "git add <file>..." to include in what will be committed)
	chap06/index.html
```

`On branch design-a` と表示されていることも確認してください．いま `design-a` ブランチで作業している証拠です．

```bash
git add chap06/index.html
```
```bash
git commit -m "feat: デザインAのサイトを追加"
```

**ポイント**：コミットメッセージの `feat:` は，「新しい機能（feature）を追加した」という意味の接頭辞です．

---

### 1-C. `design-b` ブランチを作る（ここが重要！）
次に，**`design-a` からではなく，`main-06` から**もう1本の枝を伸ばします．

#### 1. `main-06` ブランチに戻る
```bash
git switch main-06
```

#### 2. `chap06` フォルダを確認する
```bash
ls chap06
```

表示例：
```
README.md  template
```

あれ？さっき作った `index.html` がありませんね？
ブラウザのタブを再読み込みしても，「ファイルが見つかりません」と表示されるはずです．

`chap06/index.html` は，**`design-a` ブランチにコミットしたファイル**です．`main-06` ブランチには存在しません．
**ブランチを切り替えると，フォルダの中身も，そのブランチの状態に入れ替わります．**

> 消えてしまったわけではありません．`design-a` に戻れば，ちゃんと戻ってきます（実習2で確かめます）．

#### 3. 新しいブランチを作成して移動する
```bash
git branch design-b
```
```bash
git switch design-b
```

確認します：
```bash
git branch
```

表示例：
```
  design-a
* design-b
  main-05
  main-06
```

#### 4. 生成AIにサイト（デザインB）を作ってもらう
1-Bと同じ手順で，もう1つのサイトを作ります．

```bash
touch chap06/index.html
```

今度は，**新しいチャットを開いて**（前の会話に引っぱられないようにするため），依頼文を貼り付けたあと，チャットの入力欄で「デザインの雰囲気」の行だけを書きかえてから送信します．
あえて，デザインAとはまったく違う雰囲気にしてみましょう．

```text
- デザインの雰囲気：（例）ポップでカラフル／黒を基調にしたクールなダークモード／和風で落ち着いた感じ／雑誌の誌面風／レトロゲーム風
```

返ってきたコードを `chap06/index.html` に貼り付けて保存したら，ブラウザで再読み込みして表示を確認し，**1-Bの手順6と同じように公開してよい内容か確認**しましょう．

#### 5. 変更をステージング＆コミットする
```bash
git status
```

`On branch design-b` と表示されていることを確認してから，コミットします．

```bash
git add chap06/index.html
```
```bash
git commit -m "feat: デザインBのサイトを追加"
```

---

### 1-D. 生成AIが使えないときは
生成AIが使えない場合は，`chap06/template/index.html` にあるサンプルを使って，同じ実習ができます．

`design-a` では，サンプルをコピーして，`（ ）` の部分を自分の `PROFILE.md` の内容に書きかえます．

```bash
cp chap06/template/index.html chap06/index.html
```

`design-b` でも同じようにコピーしたあと，ファイルの上のほうにある「色の設定」の色だけを変えてみましょう．

```css
:root {
  --main-color: #ff9800;  /* メインの色 */
  --bg-color: #1e1e1e;    /* ページの背景の色 */
  --card-color: #2b2b2b;  /* カードの背景の色 */
  --text-color: #eeeeee;  /* 文字の色 */
}
```

コピーしたあとは，1-B・1-Cの「ブラウザで表示する」以降の手順と同じように進めてください．

---

## 実習2：ブランチを切り替えて，比べてみよう

### 2-A. サイトが入れ替わるのを見る
実習1で開いたブラウザのタブ（`chap06/index.html`）を使います．

```bash
git switch design-a
```

ブラウザで**再読み込み**（Windows：`F5`，Mac：`Command + R`）してみましょう．デザインAが表示されます．

```bash
git switch design-b
```

もう一度再読み込みしてみましょう．デザインBに変わりました！

**同じ `chap06/index.html` というファイルなのに，ブランチによって中身がまったく違います．**
`git switch` は，「HEAD（いまいる場所）を移動して，フォルダのファイルを，そのブランチの最新コミットの状態に書きかえる」コマンドなのです．

### 2-B. 枝分かれを可視化する
```bash
git log --oneline --graph --branches
```

**オプションの意味**：
- `--oneline`：1行で簡潔に表示
- `--graph`：枝分かれを線で表示
- `--branches`：自分のパソコンにあるすべてのブランチを表示

表示例：
```
* 3c4d5e6 (HEAD -> design-b) feat: デザインBのサイトを追加
| * 1a2b3c4 (design-a) feat: デザインAのサイトを追加
|/
* 7f8e9d0 (main-06) 第5回のプロフィールを main-05 から持ってくる
* 9a8b7c6 (origin/main-06) 第六回の講義資料をアップロード
* ae6fbd2 Dockerテスト環境のアップデート
| * 89e9b5e (main-05) 趣味などを追加
| * 6338599 基本情報を追加
|/
* d6e7885 (origin/main-05, origin/HEAD) 第5回講義資料の追加
* 28e28bc (origin/main) Initial commit
```

**見方**：
- `*` がコミットを表しています
- `|` や `/` が枝分かれを表しています
- `HEAD -> design-b` は，「いま `design-b` にいる」という意味です

よく見ると，**枝分かれが2か所**あります．
1. 下のほう：`d6e7885`（第5回の資料）から，あなたの `main-05` と，第6回の資料の `main-06` に分かれている（0-5で見た枝分かれ）
2. 上のほう：`main-06` から，`design-a` と `design-b` に分かれている（今日作った枝分かれ）

> ハッシュの値は人によって違います．また，`design-a` と `design-b` の行の順番は，入れ替わって表示されることもあります．

### 2-C. ブランチ間の差分を見る
2つのブランチで，何がどれくらい違うかを見てみましょう．

```bash
git diff --stat design-a design-b
```

表示例：
```
 chap06/index.html | 214 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 120 insertions(+), 94 deletions(-)
```

中身の違いを詳しく見ることもできます（`q` キーで終了）．

```bash
git diff design-a design-b
```

- `-` で始まる行（赤）：`design-a` にだけある行
- `+` で始まる行（緑）：`design-b` にだけある行

AIが2つのデザインを，CSSのどこを変えて作り分けたのかを探してみましょう．

`main-06` と比べるとどうなるでしょうか？

```bash
git diff --stat main-06 design-a
```

`main-06` には `chap06/index.html` がないので，ファイルがまるごと追加されていることがわかります．

---

## 実習3：ブランチの正体をのぞく
最後に，ブランチの「正体」を見てみましょう．
実は，ブランチはとてもシンプルな仕組みで動いています．

### 3-A. `.git/refs/heads` をのぞく
```bash
ls .git/refs/heads
```

表示例：
```
design-a  design-b  main-05  main-06
```

自分のブランチと同じ名前のファイルがありますね．

### 3-B. ブランチのファイルの中身を見る
```bash
cat .git/refs/heads/design-a
```

表示例：
```
1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b
```

40文字の英数字……見覚えがありませんか？
これは**コミットハッシュ（コミットID）**です．2-Bの `git log` で表示された `design-a` のハッシュと，先頭7文字を見比べてみましょう．

```bash
cat .git/refs/heads/design-b
```
```bash
cat .git/refs/heads/main-06
```

どのブランチのファイルにも，コミットIDが1行書かれているだけです．

#### 第5回の `git cat-file` で，枝分かれの正体を見る
`design-a` が指しているコミットの中身を，第5回で学んだ `git cat-file` で見てみましょう（`1a2b3c4` の部分は，自分の画面に表示されたハッシュに置きかえてください）．

```bash
git cat-file -p 1a2b3c4
```

表示例：
```
tree 7e6d5c4b3a2918f7e6d5c4b3a2918f7e6d5c4b3a
parent 7f8e9d0c1b2a3948576a5b4c3d2e1f0a9b8c7d6e
author Taku Shoku <taku@example.com> 1794115577 +0900
committer Taku Shoku <taku@example.com> 1794115577 +0900

feat: デザインAのサイトを追加
```

`parent` は `main-06` のコミット（`7f8e9d0...`）です．
`design-b` のコミットも同じように見てみると，`parent` は**まったく同じ** `main-06` のコミットになっているはずです．

**枝分かれの正体は，「同じ親（parent）をもつコミットが2つある」という状態**だったのです．

### 3-C. `HEAD` の中身を見る
最後に，`HEAD` という特別なファイルの中身を見てみましょう．

```bash
cat .git/HEAD
```

表示例：
```
ref: refs/heads/design-b
```

`HEAD` は，「いまいるブランチ」を指すポインタです．
この例では，`design-b` ブランチにいることがわかります．

別のブランチに切り替えて，もう一度確認してみましょう：
```bash
git switch design-a
```
```bash
cat .git/HEAD
```

表示例：
```
ref: refs/heads/design-a
```

`HEAD` の指す先が変わりましたね！

### ブランチの正体
つまり，**ブランチの正体とは，コミットIDが1行書かれただけの小さなテキストファイル**だったのです．

```
  HEAD
   |
   v
  design-a ---> 1a2b3c4 ---+
                           +---> 7f8e9d0 <--- main-06
  design-b ---> 3c4d5e6 ---+
```

- `1a2b3c4`（デザインAのサイトを追加）と `3c4d5e6`（デザインBのサイトを追加）は，どちらも `7f8e9d0` を parent にもつコミットです
- `design-a`・`design-b`・`main-06` は，それぞれのコミットを指しているだけのポインタです
- `HEAD` は，いまいるブランチ（この図では `design-a`）を指しています

まとめると：
- ブランチは，コミットを指す「ポインタ（矢印）」です．実体は `.git/refs/heads` にある小さなファイルです
- `HEAD` は，「いまいるブランチ」を指すポインタです
- `git branch` は，コミットIDを書いたファイルを1つ作るだけなので，一瞬で終わります
- `git switch` は，`HEAD` の中身を書きかえて，フォルダのファイルをそのブランチの状態に入れ替えます
- `git commit` すると，新しいコミットが作られ，いまいるブランチのファイルが新しいコミットIDに書きかわります．だから枝が伸びていくのです

---

## 演習課題：ブランチの枝分かれと差分を提出する
次の3つのコマンドを実行し，**出力結果をそのままコピーして**，課題に貼り付けて提出してください．
（いまどのブランチにいても実行できます）

```bash
git log --oneline --graph --branches
```
```bash
git diff --stat main-06 design-a
```
```bash
git diff --stat main-06 design-b
```

`git diff --stat` の表示例：
```
 chap06/index.html | 186 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
```

> `git diff` に `--stat` をつけるのは，HTMLファイルの差分がとても長く，画面に収まらないためです．
> `--stat` をつけると，「どのファイルが何行変わったか」だけを短く表示できます．

### 提出前のチェック
- [ ] `git log` の出力で，`main-06` から `design-a` と `design-b` の2つのブランチが枝分かれしている
- [ ] `git log` の出力に，0-6でした「第5回のプロフィールを main-05 から持ってくる」コミットがある
- [ ] 2つの `git diff --stat` の出力で，どちらのブランチにも `chap06/index.html` が追加されている

---

## 困ったときは

| 症状 | 原因と対処 |
| --- | --- |
| `git switch main-06` で `fatal: invalid reference: main-06` などと表示される | `git fetch origin` をしていない可能性があります．0-3からやり直しましょう |
| `git restore --source=main-05` で `fatal: could not resolve 'main-05'` と表示される | 手元に `main-05` ブランチがありません（クローンし直した場合など）．`chap05/PROFILE.md` に自己紹介を書き直して保存してから，0-6の `git add` に進みましょう |
| 0-6で持ってきた `PROFILE.md` が空っぽのまま | 第5回で `PROFILE.md` をコミットしていない可能性があります．ここで `chap05/PROFILE.md` に自己紹介を書いて保存してから，0-6の `git add` に進みましょう |
| `error: Your local changes to the following files would be overwritten by checkout` | コミットしていない変更があるため，ブランチを切り替えられません．`git status` で確認し，`git add` → `git commit` してから切り替えましょう |
| `fatal: a branch named 'design-a' already exists` | そのブランチはすでに作成済みです．`git switch design-a` で移動だけしましょう |
| 1-Cで `main-06` に戻っても `chap06/index.html` が消えない | `design-a` でコミットし忘れています．`git status` で `Untracked files: chap06/index.html` と出たら，`git switch design-a` で戻ってから，1-Bの手順7をやり直しましょう．**コミットしていないファイルは，どのブランチにも属していません** |
| `git status` で `template` の中のファイルが `modified` と表示される | テンプレートを書きかえてしまっています．`git restore chap06/template` で元に戻せます |
| `open: command not found` | Windowsでは `start chap06/index.html` を使うか，エクスプローラーで `index.html` をダブルクリックしましょう |
| ブラウザで日本語が文字化けする | `index.html` に `<meta charset="UTF-8">` が入っているか確認しましょう．入っていなければ，AIに追加を頼みましょう |
| `git log` や `git diff`，`git show` の画面から戻れない | `q` キーを押すと戻れます |
| `.git/refs/heads` にブランチ名のファイルがない | ブランチの情報が `.git/packed-refs` というファイルにまとめて保存されている場合があります．`git rev-parse ブランチ名` で，同じコミットIDを表示できます |

## まとめ

### この回で学んだコマンド
- **`git fetch origin`**：GitHubから最新のブランチを取ってくる（自分のファイルは書きかわらない）
- **`git branch ブランチ名`**：新しいブランチを作成
- **`git switch ブランチ名`**：ブランチを切り替え（フォルダの中身も入れ替わる）
- **`git branch`**：ブランチの一覧を表示（`*` がいまいるブランチ）
- **`git show ブランチ名:ファイルの場所`**：別のブランチにあるファイルの中身を，切り替えずに表示
- **`git restore --source=ブランチ名 ファイルの場所`**：別のブランチにあるファイルを持ってくる
- **`git log --oneline --graph --branches`**：ブランチの枝分かれを可視化
- **`git diff --stat ブランチ1 ブランチ2`**：ブランチ間で変わったファイルと行数を表示
- **`git diff ブランチ1 ブランチ2`**：ブランチ間の差分を詳しく表示
- **`cat .git/refs/heads/ブランチ名`**：ブランチの実体（コミットID）を表示
- **`cat .git/HEAD`**：いまいるブランチを表示

### ブランチの仕組み
1. ブランチは，コミットを指すポインタ．実体は `.git/refs/heads` にある，コミットIDが書かれた小さなファイル
2. `HEAD` は，いまいるブランチを指す特別なポインタ
3. `git switch` でブランチを切り替えると，フォルダのファイルもそのブランチの状態に入れ替わる
4. 枝分かれとは，同じ親（parent）をもつコミットが複数ある状態
5. 別のブランチにあるファイルは，切り替えなくても取り出せる（`git show`，`git restore --source`）

---

## 発展：もっと学びたい人へ

### 3つ目のデザインを試す
`git switch -c` を使うと，ブランチの作成と移動を一度にできます．

```bash
git switch main-06
```
```bash
git switch -c design-c
```

また，`design-a` から枝を伸ばして「デザインAの改良版」を作ることもできます．

```bash
git switch design-a
```
```bash
git switch -c design-a2
```

作ったあとに `git log --oneline --graph --branches` を実行すると，どこから枝分かれしたかによって，グラフの形が変わることがわかります．

### ブランチの削除
使わなくなったブランチは削除できます．

```bash
git branch -d ブランチ名
```

ただし，どこにも取りこまれていない（マージされていない）コミットがあるブランチは，作業が失われないように `-d` では削除できません．
**今日作った `design-a` と `design-b` は，次回以降も使うので削除しないでください．**

---

## 参考資料
- [Git公式ドキュメント - ブランチとは](https://git-scm.com/book/ja/v2/Git-%E3%81%AE%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E6%A9%9F%E8%83%BD-%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%A8%E3%81%AF)
- [Learn Git Branching（ブランチの図解）](https://learngitbranching.js.org/?locale=ja)

お疲れさまでした！ブランチの基本を理解できましたか？
次回は，手元のコミットをGitHubに送る `git push` を学び，今日作ったサイトを `https://ユーザー名.github.io/` として公開します．

### 次回までの準備
- **GitHubアカウント**を作っておいてください（ https://github.com/signup ）．メール認証に時間がかかることがあるので，早めに作っておきましょう
  - **ユーザー名が，そのままサイトのURL（`https://ユーザー名.github.io/`）になります**．公開されてもよい名前にしましょう
- `design-a` と `design-b` の，どちらのデザインを公開するか決めておきましょう
