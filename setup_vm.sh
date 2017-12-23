#!/bin/bash
set -e
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y build-essential ctags libncurses5-dev python-pip
pip install -r khack/requirements.txt

sudo ln -fs `realpath khack/khack` /usr/local/bin/khack

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
