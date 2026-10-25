" Vim の設定ファイル（コンテナ内の /root/.vimrc にコピーされます）

" ~/.vimrc があると Vim 標準の設定（defaults.vim）が読み込まれなくなるので，先に読み込む
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" 文字コード
set encoding=utf-8
scriptencoding utf-8
" ファイルを開くときに試す文字コードの順番（Windowsで作ったShift_JISのファイルも開ける）
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1
set fileformats=unix,dos,mac

" 表示
syntax on
set number          " 行番号を表示
set laststatus=2    " ステータスラインを常に表示
" ステータスラインに ファイル名 [文字コード][改行コード] 行:列 を表示
set statusline=%f\ %m%r%=[%{&fileencoding!=''?&fileencoding:&encoding}][%{&fileformat}]\ %l:%c

" 編集
set backspace=indent,eol,start   " BackSpace で改行やインデントも消せるようにする
set expandtab tabstop=4 shiftwidth=4
set autoindent

" マウスでターミナルの文字を選択・コピーできるように，Vim側のマウス操作はオフにする
set mouse=
