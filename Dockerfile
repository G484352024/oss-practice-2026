# ベースとなるイメージを指定
FROM ubuntu:latest

# インストール中に対話的な質問（タイムゾーンの選択など）で止まらないようにする
ARG DEBIAN_FRONTEND=noninteractive

# Gitと，日本語を扱うために必要なものをインストールする
#   locales : 日本語ロケール（ja_JP.UTF-8）を作るため
#   tzdata  : 日本時間（Asia/Tokyo）を使うため
#   zsh     : コンテナ内で使うシェル
RUN apt-get update && apt-get install -y \
    git \
    vim \
    less \
    zsh \
    locales \
    tzdata \
&& locale-gen ja_JP.UTF-8 \
&& rm -rf /var/lib/apt/lists/*

# 日本語（UTF-8）と日本時間を使う設定
#   LANG を設定しないと文字コードが ASCII 扱いになり，日本語が文字化けする
#   TZ を設定しないと，コミットの日時が日本時間（+0900）にならない
ENV LANG=ja_JP.UTF-8 \
    TZ=Asia/Tokyo \
    SHELL=/usr/bin/zsh

# コンテナ内のGit全体（--system）の設定
#   core.quotepath false : 日本語のファイル名を "\346\227\245..." のように表示しない
#   safe.directory /work : マウントしたフォルダを「安全なリポジトリ」として扱う
RUN git config --system core.quotepath false \
&& git config --system safe.directory /work

# シェルとVimの設定ファイル（dotfiles）をホームディレクトリにコピーする
COPY docker/.zshrc docker/.bashrc docker/.vimrc /root/

# コンテナ内の作業ディレクトリを指定
WORKDIR /work

# コンテナ起動時に実行されるコマンド
CMD ["zsh"]
