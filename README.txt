# FreeBSD 14.2 の設定ファイル(※作成中)

FreeBSD 14.2 インストール&設定メモ 2025-05-XX 第9版 に対応
https://moginwc.sakura.ne.jp/FreeBSD142InstallGuide2.pdf

インストールをお急ぎの方は、下記を実行してください。

ステップ１．FreeBSD 14.2 インストール&設定メモ 2025-05-XX 第9版 の
　　　　　　29〜74ページ（sudoを設定する）までを実行する。
ステップ２．# pkg install -y git を実行する。
ステップ３，# exit でログアウトする。
ステップ４．pcuser でログインする。
ステップ５．% git clone https://github.com/moginwc/freebsd142_2 を実行する。
ステップ６．% cd freebsd142_2
ステップ７．% tcsh ./install.tcsh
　　　　　　(sudoのパスワード、および最後にファイル共有smbのパスワード入力があります)
ステップ８．% sudo shutdown -r now
ステップ９．144ページ以降を参照。

--------

Wineのインストールをお急ぎの方は、引き続き下記を実行してください。

ステップ１．pcuser でログインする。
ステップ２．% cd freebsd142_2
ステップ３．% tcsh ./install_wine.tcsh
　　　　　　（秀丸エディタ、WinMerge、Binary Editor BZもインストールされます。
　　　　　　　途中、何かフォルダーのようなものが表示されますが、閉じてください）
ステップ４．いったんログアウトし、再度ログインする

[EOF]
