echo "---------- Laravel ----------"
if [ ! -d "/workspaces" ]; then
  echo install laravel
  sudo mkdir /workspaces
fi

sudo chown vagrant:vagrant /workspaces
cd /workspaces

if [ ! -d "/workspaces/laravel_a" ]; then
  composer create-project laravel/laravel laravel_a --prefer-dist
  sed -i "s/<title>.*<\/title>/<title>Laravel Side A<\/title>/g" laravel_a/resources/views/welcome.blade.php
fi
if [ ! -d "/workspaces/laravel_b" ]; then
  composer create-project laravel/laravel laravel_b --prefer-dist
  sed -i "s/<title>.*<\/title>/<title>Laravel Side B<\/title>/g" laravel_b/resources/views/welcome.blade.php
fi

# SELinux File Accsess
sudo semanage fcontext -a -t httpd_sys_content_t "/workspaces/laravel_a(/.*)?"
sudo semanage fcontext -a -t httpd_sys_rw_content_t "/workspaces/laravel_a/storage(/.*)?"
sudo semanage fcontext -a -t httpd_sys_rw_content_t "/workspaces/laravel_a/bootstrap/cache(/.*)?"
sudo semanage fcontext -a -t httpd_sys_content_t "/workspaces/laravel_b(/.*)?"
sudo semanage fcontext -a -t httpd_sys_rw_content_t "/workspaces/laravel_b/storage(/.*)?"
sudo semanage fcontext -a -t httpd_sys_rw_content_t "/workspaces/laravel_b/bootstrap/cache(/.*)?"

# fcontext Apply
restorecon -R /workspaces/laravel_a
restorecon -R /workspaces/laravel_b
