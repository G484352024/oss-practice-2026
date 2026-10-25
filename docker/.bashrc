# bash の設定ファイル（コンテナ内の /root/.bashrc にコピーされます）
# コンテナは zsh で起動しますが，`bash` と打って bash を使うこともできます．

# 対話的に使うとき以外は何もしない
[ -z "$PS1" ] && return

# 文字コード・タイムゾーン（Dockerfile の ENV が無い環境でも動くように）
export LANG=${LANG:-ja_JP.UTF-8}
export TZ=${TZ:-Asia/Tokyo}
export EDITOR=vim
export LESSCHARSET=utf-8

# 履歴
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoredups
shopt -s histappend

# プロンプトにGitのブランチ名を表示する
#   例: root@abc123 /work/chap05 (main-05)
#   #
if [ -f /usr/lib/git-core/git-sh-prompt ]; then
    . /usr/lib/git-core/git-sh-prompt
    PS1='\[\e[32m\]\u@\h\[\e[0m\] \[\e[34m\]\w\[\e[0m\]\[\e[33m\]$(__git_ps1 " (%s)")\[\e[0m\]\n\$ '
fi

# ls に色をつける
alias ls='ls --color=auto'
alias ll='ls -alF'
