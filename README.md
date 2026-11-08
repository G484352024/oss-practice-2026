# oss-practice-2026
拓殖大学工学部　2026年度『オープンソースソフトウェア』の実習用リポジトリです

## 講義内容

### [第5回：Gitの基本操作（add と commit）](./chap05/README.md)

Gitの基本的なコマンドである `git add` と `git commit` について学びます．
自己紹介ファイル `PROFILE.md` を書きながら，変更の記録方法や，コミットの仕組みを理解します．
ここで書いた `PROFILE.md` は，第6回で生成AIを使ってプロフィールサイトを作るときの素材になります．

### [第6回：Gitブランチ実習（生成AIでポートフォリオサイトを作り比べる）](./chap06/README.md)

Gitのブランチについて学びます．
第5回で書いた `PROFILE.md` をもとに，生成AIで2種類のデザインのサイトを別々のブランチで作り，切り替えて比べます．
ブランチの正体（`.git/refs/heads` と `.git/HEAD`）をのぞき，`git log --graph` と `git diff` で枝分かれと差分を確かめます．
作ったサイトは，第7回で `git push` して GitHub Pages（`https://ユーザー名.github.io/`）で公開します．

## テスト用環境の立ち上げ

何も設定されていない環境を `docker` を利用することで起動できます．

### docker container のビルド

```bash
docker build -t git-ubuntu .
```

### ubuntu イメージの起動

```bash
docker run -it --rm -v "$(pwd):/work" git-ubuntu
```

