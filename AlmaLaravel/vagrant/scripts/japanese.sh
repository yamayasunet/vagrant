sudo dnf install -y glibc-langpack-ja

echo "---------- 日本語に設定 ----------"
# 日本語キーボードを標準に
localectl set-keymap jp106

# ローカル時間を日本に
timedatectl set-timezone Asia/Tokyo

# 言語を日本に
localectl set-locale LANG=ja_JP.UTF-8

# 再起動
systemctl restart rsyslog.service

# 最後に確認
echo "---------- 設定結果 ----------"
localectl status
timedatectl status
