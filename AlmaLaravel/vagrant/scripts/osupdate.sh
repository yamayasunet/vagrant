# OS Update
dnf upgrade --refresh -y

# metadata delete
dnf clean metadata

# Extra Packages for Enterprise Linux 8
dnf -y install epel-release

# Remi's Modular repository for Enterprise Linux 8
dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm

# semanage コマンドをインストール
dnf -y install policycoreutils-python-utils
