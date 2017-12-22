# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "bento/debian-9.2"
	config.vm.synced_folder "./khack", "/home/vagrant/khack"
	config.vm.synced_folder "./linux-config", "/home/vagrant/linux-config"
	config.vm.synced_folder "./module", "/home/vagrant/module"

	# The following will not work on case-insensitive filesystems like those provided by
	# Windows and macOS, as the Linux kernel source tree has files that differ only by case.
        unless Vagrant::Util::Platform.fs_case_sensitive?
	  config.vm.synced_folder "./linux-source", "/home/vagrant/linux-source"
        end

	config.vm.provision "shell", path: "setup_vm.sh"
end
