# nginxをインストール
echo "---------- nginx ----------"
dnf install -y nginx
systemctl enable nginx
systemctl start nginx


echo "---------- nginx ----------"
nginx -v
systemctl enable --now nginx
systemctl status nginx
