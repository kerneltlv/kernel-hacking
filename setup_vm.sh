#!/usr/bin/env bash
echo "Installing dependencies..."
sudo apt-get install -y fakeroot linux-source build-essential libncurses5-dev python-pip

echo "Extracting kernel source..."
mkdir linux-source
tar -x -f /usr/src/linux-source-* --strip 1 -C linux-source
cp /boot/config* linux-source/.config
chown -R vagrant:vagrant linux-source/

mkdir boot-backup
cp /boot/vmlinuz* boot-backup/
cp /boot/initrd* boot-backup
cp /boot/config* boot-backup
cp /boot/System.map* boot-backup

pip install -r khack/requirements.txt

sudo ln -s `realpath khack/khack` /usr/local/bin/khack