# KernelTLV Linux Hacking Environment

## Purpose 
This project includes an environment for building a Linux kernel and kernel modules and running them.
The environment is created in a virtual machine using a Debian-based Linux distribution.

## Dependencies
1. [Vagrant](https://www.vagrantup.com/)
1. [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (or your favorite [supported](https://www.vagrantup.com/docs/providers/) VM provider)
1. If using VirtualBox, install the vagrant-vbguest plugin (`vagrant plugin install vagrant-vbguest`).

## Usage
Run `vagrant up` where you cloned the repo (where `Vagrantfile` is) to create a shiny new VM with everything you need in it.

This will take a while, but at the end your home directory inside the VM will have the following:

* `linux-source`: Linux kernel sources ready to be compiled with the configuration of the running Debian kernel.
* `boot-backup`: A backup of `/boot`, just in case.
* `khack`: Source code for the khack utility.
* `module`: Scaffold code for a kernel module.

`khack` and `module` are set up to be shared with the host operating system, so you can use your favorite editor to edit files.
Everything else can be done the traditional way (compile and install the kernel, etc) or using khack for convenience.

## khack
khack is a utility meant to simplify and ease the burden of hacking on the kernel.
Its source is available under `khack` and it can be used as simply `khack` within the VM as it is symlinked into the right place (see `setup_vm.sh`).

For example:

* `khack kernel make` will build the kernel in `~\linux-source`.
* `khack kernel install` will install the built kernel so that it will run when the VM is restarted.
* `khack kernel running?` will report of the latest compiled kernel is actually running.

Experiment and have fun,

KernelTLV Team
