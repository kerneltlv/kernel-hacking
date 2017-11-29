# -*- mode: ruby -*-
# vi: set ft=ruby :
HOME_DISK = '.vagrant/machines/default/hdd.vdi'

Vagrant.configure("2") do |config|
	config.vm.box = "bento/debian-9.2"
	config.vm.synced_folder "./khack", "/home/vagrant/khack"

	# The following will not work on case-insensitive filesystems like those provided by
	# Windows and macOS, as the Linux kernel source tree has files that differ only by case.
	# If your host is Linux, you can uncomment this line to share the kernel source
	# directory with your host for easy editing.

	# config.vm.synced_folder "./linux-source", "/home/vagrant/linux-source"

	config.vm.provision "shell", path: "setup_vm.sh"
end
