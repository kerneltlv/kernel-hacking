# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	config.vm.box = "bento/debian-9.3"
	config.vm.synced_folder "./khack", "/home/vagrant/khack"
	config.vm.synced_folder "./linux-config", "/home/vagrant/linux-config"
	config.vm.synced_folder "./system-config", "/home/vagrant/system-config"
	config.vm.synced_folder "./module", "/home/vagrant/module"

	config.vm.network "forwarded_port", guest: 139, host: 10139

	config.vm.provision "shell", path: "setup_vm.sh"
end
