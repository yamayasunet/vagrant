# PHP8をインストール
dnf module reset php
dnf module enable php:remi-8.0 -y

echo "---------- php8 ----------"
dnf install -y php

echo "---------- php-fpm ----------"
dnf install -y php-fpm


# 個別設定に書き換え
sed -i "s/user = .*/user = vagrant/g" /etc/php-fpm.d/www.conf
sed -i "s/group = .*/group = vagrant/g" /etc/php-fpm.d/www.conf

sed -i "s/.listen.owner = .*/listen.owner = nginx/g" /etc/php-fpm.d/www.conf
sed -i "s/.listen.group = .*/listen.group = nginx/g" /etc/php-fpm.d/www.conf
sed -i "s/.listen.mode = .*/listen.mode = 0660/g" /etc/php-fpm.d/www.conf
sed -i "s/listen.acl_users =/;listen.acl_users =/g" /etc/php-fpm.d/www.conf

echo "---------- php8(setgting) ----------"
# http headerにPHPのバージョンを出さない
# expose_php = Off
sed -i "s/expose_php = .*/expose_php = Off/" /etc/php.ini

# エラーを出力する
# display_errors = On
sed -i "s/display_errors = .*/display_errors = On/" /etc/php.ini

# 開発用にエラーが全部出るようにする
# error_reporting = E_ALL
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php.ini

# 時間のデフォルトを東京に変更
# date.timezone = Asia/Tokyo
sed -i "s/;date.timezone.*/date.timezone = Asia\/Tokyo/" /etc/php.ini

# mbstring系の設定をすべて有効にする
# mbstring.language = Japanese
sed -i "s/;mbstring.language.*/mbstring.language = Japanese/" /etc/php.ini


# php-fpmをサービスに追加
systemctl enable --now php-fpm
systemctl status php-fpm

# SELinux Port Accsess
semanage port -a -t http_port_t -p tcp 8801
semanage port -a -t http_port_t -p tcp 8802

# 対になるnginxの設定

# nginxのデフォルト設定を殺す(バージョンにより条件が変わります！)
sed -i -e "38,57s:^:#:" /etc/nginx/nginx.conf

# nginx 個人設定の追加
cp /vagrant/scripts/laravel_a.conf /etc/nginx/conf.d/laravel_a.conf
cp /vagrant/scripts/laravel_b.conf /etc/nginx/conf.d/laravel_b.conf

# 設定を反映するためnginxを再起動
systemctl restart nginx


echo "---------- PHP ----------"
php -version
php-fpm -v

