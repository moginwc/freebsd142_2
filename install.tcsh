#!/bin/tcsh

# システム起動時に ntpd が起動するよう設定する
sudo service ntpd enable
sudo cp ./etc_ntp.conf /etc/ntp.conf

# 省エネ動作の設定を行う
sudo service powerd enable

# グラフィックドライバーのインストール(ここではIntel向け設定)
sudo pkg install -y -q drm-510-kmod
sudo sysrc kld_list+=i915kms
sudo pw groupmod video -m pcuser

# vimエディターをインストールする
sudo pkg install -y -q vim
cp ./.vimrc ~

# シェルスクリプト初期設定
cp ./.cshrc ~
cp ./.login ~

# X-Window System をインストールする
sudo pkg install -y -q xorg

# ウィンドウシステムをインストールする
sudo pkg install -y -q fvwm
mkdir ~/icons
cp /usr/local/share/fvwm/pixmaps/programs.xpm ~/icons
cp /usr/local/share/fvwm/pixmaps/xterm-sol.xpm ~/icons
sudo pkg install -y -q ImageMagick7
magick ~/icons/programs.xpm -trim +repage -scale 200% ~/icons/programs.png
magick ~/icons/xterm-sol.xpm ~/icons/xterm-sol.png
sudo pkg install -y -q fvwm3
sudo pkg install -y -q ja-font-ipa noto-sans-jp

# ウィンドウシステムの初期設定
cp ./.xinitrc ~
cp ./.fvwm2rc ~

# 初期設定ファイルのコメント外し
sed -i '' 's/^##//g' ~/.fvwm2rc
sed -i '' 's/^##//g' ~/.xinitrc
sed -i '' 's/^##//g' ~/.login

# 端末エミュレータのインストールと設定
sudo pkg install -y -q mlterm
cp -r ./.mlterm ~

# 入力メソッド・日本語入力システムのインストールと設定
sudo pkg install -y -q ja-uim-anthy uim-gtk uim-gtk3 uim-qt5
cp -r ./.xkb ~

# 入力メソッド・日本語入力システムの初期設定
cp -r ./.uim.d-anthy ~
mv ~/.uim.d-anthy ~/.uim.d

# ユーザー辞書ファイルの作成
mkdir ~/.anthy
## touch ~/.anthy/private_words_default
cp -r ./.anthy ~

# アプリのインストール
sudo pkg install -y -q firefox-esr
sudo pkg install -y -q scrot
sudo pkg install -y -q xlockmore
sudo pkg install -y -q lupe
sudo pkg install -y -q xpad3

# xpadの初期設定、他config設定
cp -r ./.config ~

# パッケージのアップデート
sudo pkg update -f
sudo pkg upgrade

# 5-4.ログインした際のメッセージを、Last login以外、表示させない
sudo mv /etc/motd.template /etc/motd.template.old
sudo touch /etc/motd.template

# 8-6.chromium（ウェブブラウザ）を使用したい
sudo pkg install -y -q chromium webfonts

# 9-1. 9-2.
cp /usr/local/lib/firefox/browser/chrome/icons/default/default48.png ~/icons/firefox.png
cp /usr/local/share/icons/hicolor/48x48/apps/chrome.png ~/icons/chrome.png
sudo pkg install -y -q xload
sudo pkg install -y -q xbatt

# conky設定
sudo pkg install -y -q conky
cp ./.conkyrc ~

# 文字コード表
cp -r ./html ~

# クリップボード
sudo pkg install -y -q autocutsel

# 起動時のメッセージをできるだけ表示させない
sudo cp ./root_boot.config /boot.config
grep '^autoboot_delay=' /boot/loader.conf > /dev/null
if ( $status == 0 ) then
    sudo sed -i '' 's/^autoboot_delay=.*/autoboot_delay="-1"/' /boot/loader.conf
else
    echo 'autoboot_delay="-1"' | sudo tee -a /boot/loader.conf
endif

# visudoの設定
set addstr = "pcuser ALL=NOPASSWD: /sbin/shutdown"
grep -F -- "$addstr" /usr/local/etc/sudoers > /dev/null
if ( $status != 0 ) then
    echo "$addstr" | sudo tee -a /usr/local/etc/sudoers
endif

# 固定IPv4の設定(コメントアウト)
set addstr = '#ifconfig_em0="inet 192.168.1.8/24"'
grep -F -- "$addstr" /etc/rc.conf > /dev/null
if ( $status != 0 ) then
    echo "$addstr" | sudo tee -a /etc/rc.conf
endif

# 固定IPv4のデフォルトゲートウェイの設定(コメントアウト)
set addstr = '#defaultrouter="192.168.1.1"'
grep -F -- "$addstr" /etc/rc.conf > /dev/null
if ( $status != 0 ) then
    echo "$addstr" | sudo tee -a /etc/rc.conf
endif

# IPv6の設定(コメントアウト)
set addstr = '#ifconfig_em0_ipv6="inet6 accept_rtadv"'
grep -F -- "$addstr" /etc/rc.conf > /dev/null
if ( $status != 0 ) then
    echo "$addstr" | sudo tee -a /etc/rc.conf
endif

# mozc
cp -r ./.uim.d-mozc/customs/custom-mozc.scm ~/.uim.d/customs/
mkdir ~/.mozc
/usr/local/bin/xxd -r -p ./.mozc/config1.bin > ~/.mozc/config1.db

# 実行権を付与する
chmod +x ~/.config/nsxiv/exec/image-info
chmod +x ~/.config/nsxiv/exec/key-handler

# rsyncバックアップ対象・除外設定ファイルのコピー
cp ./.backup_config ~
cp ./.backup_exclude_config ~

# gtkrc-2.0
cp ./.gtkrc-2.0 ~

# Xresouces
cp ./.Xresources ~

# sylpheed-2.0
sudo pkg install -y sylpheed
cp -r ./.sylpheed-2.0 ~

# bin
cp -r ./bin ~

# インストール
sudo pkg install -y gimp
sudo pkg install -y nsxiv
sudo pkg install -y qgis
sudo pkg install -y openscad
sudo pkg install -y freerdp
sudo pkg install -y tigervnc-viewer

# サンプルファイル
cp line.csv point.csv ant_tower.scad ~

# 7-3. Windowsやmacとファイル共有したい（smb）
sudo pkg install -y -q samba419
sudo service samba_server enable
mkdir ~/share
sudo cp etc_smb4.conf /usr/local/etc/smb4.conf
sudo pdbedit -a -u pcuser
