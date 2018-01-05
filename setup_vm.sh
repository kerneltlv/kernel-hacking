#!/bin/bash
set -e
echo "Installing dependencies..."
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential kexec-tools ctags libncurses5-dev python-pip samba
pip install -r khack/requirements.txt

sudo ln -fs `realpath khack/khack` /usr/local/bin/khack
sudo ln -fs `realpath khack/khack-kernel` /usr/local/bin/khack-kernel
sudo ln -fs `realpath khack/khack-module` /usr/local/bin/khack-module
sudo ln -fs `realpath khack/khack-libc` /usr/local/bin/khack-libc

sudo cp system-config/smb.conf /etc/samba/smb.conf
(echo "vagrant"; echo "vagrant") | sudo smbpasswd -as vagrant
sudo systemctl restart smbd

sudo cp system-config/kexec /etc/default/kexec
sudo systemctl restart kexec

echo "Extracting kernel source..."
khack kernel get
khack kernel config minimal
chown -R vagrant:vagrant linux-source/

[ ! -e boot-backup ] || rm -r boot-backup
mkdir boot-backup
cp /boot/vmlinuz* boot-backup/
cp /boot/initrd* boot-backup
cp /boot/config* boot-backup
cp /boot/System.map* boot-backup
