#!/bin/tcsh

# wineのインストール
sudo pkg install -y wine wine-gecko wine-mono winetricks
yes | /usr/local/share/wine/pkg32.sh install wine mesa-dri
rehash # winetricksがインストールされたことを認識させる
winetricks cjkfonts corefonts
winecfg # 表示されたら、OKを押してください

# 梅ゴシックのインストール
sudo pkg install -y ja-font-ume

# 秀丸のサイレントインストール
sudo pkg install -y cabextract # 秀丸のインストーラーの実態は.cabファイル
curl -O https://hide.maruo.co.jp/software/bin/hm944_x64_signed.exe
mkdir hidemaru
cabextract -d ./hidemaru hm944_x64_signed.exe
wine ./hidemaru/hmsetup.exe /h # /hがサイレントインストールオプション

# 秀丸アイコンの抽出
sudo pkg install -y icoutils
mkdir hidemaru_icon
wrestool -x --output=./hidemaru_icon -t14 ~/.wine/drive_c/Program\ Files/Hidemaru/Hidemaru.exe
convert ./hidemaru_icon/Hidemaru.exe_14_102_1041.ico hidemaru.png
cp hidemaru-2.png ~/icons/hidemaru.png

# 秀丸の読み書き設定
wineserver -k # wine関係のサーバープロセスを終了する
set addstr = '[Software\\Wine\\AppDefaults\\Hidemaru.exe]'
grep -F -- "$addstr" ~/.wine/user.reg > /dev/null
if ( $status != 0 ) then
    echo "$addstr" | tee -a ~/.wine/user.reg
    set addstr = '"Version"="winxp"'
    echo "$addstr" | tee -a ~/.wine/user.reg
endif

# WinMergeのサイレントインストール
curl -L -O https://github.com/WinMerge/winmerge/releases/download/v2.16.42.1/WinMerge-2.16.42.1-x64-Setup.exe
wine ./WinMerge-2.16.42.1-x64-Setup.exe /VERYSILENT # サイレントインストールオプション

# BzEditor（ポータブルzip版）のインストール
curl -O https://gitlab.com/-/project/12653927/uploads/da22779e33bcec39cbe8b6bddfacef4f/Bz1987Portable.zip
unzip Bz1987Portable.zip
mkdir ~/wine_bin
cp -r Bz1987Portable ~/wine_bin
mv ~/wine_bin/Bz1987Portable ~/wine_bin/Bz

# 設定ファイルのコメント外し
sed -i '' 's/^#wine#//g' ~/.fvwm2rc
sed -i '' 's/^#wine#//g' ~/.cshrc

# 代替フォントの設定
sudo pkg install -y ja-nkf
nkf -W8 -w16L -Lw ./wine-japanese.txt > ./wine-japanese.reg
regedit ./wine-japanese.reg
##nkf -W8 -w16L -Lw ./private/font.txt > ./private/font.reg
##regedit ./private/font.reg
