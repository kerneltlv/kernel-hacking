#!/usr/bin/env bash
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y build-essential ctags libncurses5-dev python-pip
pip install -r khack/requirements.txt

sudo ln -s `realpath khack/khack` /usr/local/bin/khack

echo "Extracting kernel source..."
khack kernel get
khack kernel config minimal
chown -R vagrant:vagrant linux-source/

mkdir boot-backup
cp /boot/vmlinuz* boot-backup/
cp /boot/initrd* boot-backup
cp /boot/config* boot-backup
cp /boot/System.map* boot-backup
