# KernelTLV Linux Hacking Environment

## Purpose
This project is a way to bring up a Linux kernel development environment quickly and easily, without using tools like QEMU or building a toolchain and cross-compiling. This is done by building a kernel from the Debian-supplied package and using it with the Debian distribution.

The project also includes **khack**, a utility for taking some guesswork out of the process of hacking on the kernel as well as serving as a guide for newcomers, as an alternative for reading a lot of material online and attempting to learn by trial and error.

## Requirements
1. [Vagrant](https://www.vagrantup.com/)
1. [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
1. The vagrant-vbguest plugin (Run `vagrant plugin install vagrant-vbguest`).
1. ~15GB of free space.

## Usage
Run `vagrant up` where you cloned the repo (where `Vagrantfile` is) to create a shiny new VM with everything you need.

This will take a while.

Once it's done, run `vagrant ssh` to enter the machine and from there, depending on your level of familiarity with kernel development, either:

* Newcomer - run `khack` for an explanation of what you can do here (WIP),
* Experienced developer - run `khack --help` for a list of useful scripts,

or just ignore khack entirely and do your own thing.

## Details
Inside the VM home directory, there will be:
* `linux-source`: Linux kernel sources ready to be compiled with the minimal configuration from `linux-config`.
* `khack`: The khack utility.
* `module`: Scaffold code for a kernel module.
* `linux-config`: Premade kernel configs.
* `system-config`: Configuration files for different system-related programs, there's usually no need to touch this.
* `boot-backup`: A backup of `/boot`, just in case.

`khack`, `module` and `linux-config` are set up to be shared with the host operating system, so you can use your favorite editor to edit files in them.  
**To edit the kernel source, see below.**
Everything else can be done the traditional way (compile and install the kernel, etc) or using khack for convenience.

## Editing from host
We reveal the source via SMB/CIFS, to avoid issues with building the kernel on a VirtualBox shared directory.
To mount:

### Ubuntu
Via terminal:
```
sudo apt install cifs-utils
sudo mount -t cifs //localhost/kernel-source WHERE_TO_MOUNT -o port=10139,username=vagrant,password=vagrant,uid=$USER,gid=$USER
```
Via Nautilus:
```
smb://vagrant:vagrant@localhost:10139/kernel-source/
```

### macOS
Via terminal:
```
sudo mount -t smbfs '//vagrant:vagrant@localhost:10139/kernel-source' WHERE_TO_MOUNT
```
Via Finder:

Use Connect to Server (cmd+K) with the URL `smb://vagrant:vagrant@localhost:10139/`.

## khack
khack is meant to simplify hacking on the kernel and teach newcomers which commands actually work by, you know, showing that they actually work, saving learners from the frustration of trying to adjust incantations from an online tutorial written ten years ago.

Its source is available under `khack` and it can be used as simply `khack` within the VM as it is symlinked into the right place (see `setup_vm.sh`).

For example:

* `khack kernel make` will build the kernel in `~\linux-source`.
* `khack kernel install` will install the built kernel so that it will run when the VM is restarted.
* `khack kernel running` will report if the latest compiled kernel is actually running.

Experiment and have fun,

KernelTLV Team
