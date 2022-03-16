# AlmaLinux 8 + Laravel 9 for Vagrant(Oracle VM VirtualBox)

Vagrant(Oracle VM VirtualBox) で AlmaLinux 8をうごかしつつ、Laravelを実行するテンプレート
さらに、Laravelを２つインストールし、違うポートで運用してみる

- nginx AlumaLinuxリポジトリ上の最新
- php 8.0.x
- php-fpm(unix socket)
- laravel 最新版
- composer 最新版

できる限り日本よりの設定に変更。

localhost:8801 side_A
localhost:8802 side_B

vagrantフォルダと同階層にlaravel_a/laravel_bフォルダを作成し、Vagrantファイルの以下のコメントアウトを外すとフォルダ内のアプリが起動します
