# zsh の設定ファイル（コンテナ内の /root/.zshrc にコピーされます）

# 文字コード・タイムゾーン（Dockerfile の ENV が無い環境でも動くように）
export LANG=${LANG:-ja_JP.UTF-8}
export TZ=${TZ:-Asia/Tokyo}
export EDITOR=vim
export LESSCHARSET=utf-8

# キー操作は Emacs 風にする
# （EDITOR=vim だと zsh は Vim 風のキー操作になってしまうため，明示的に指定）
bindkey -e

# 補完で日本語のファイル名をそのまま表示する
setopt print_eight_bit

# 補完
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # 大文字・小文字を区別しない

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups share_history

# プロンプトにGitのブランチ名を表示する
#   例: root@abc123 /work/chap05 (main-05)
#   #   ← 2行目にコマンドを入力する
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a)'
precmd() { vcs_info }
setopt prompt_subst
PROMPT='%F{green}%n@%m%f %F{blue}%~%f%F{yellow}${vcs_info_msg_0_}%f
%# '

# ls に色をつける
alias ls='ls --color=auto'
alias ll='ls -alF'
