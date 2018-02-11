#!/usr/bin/python

"""KernelTLV Linux Hacking Utility

Usage:
    {executable_name} kernel get
    {executable_name} kernel config <name>
    {executable_name} kernel make
    {executable_name} kernel run
    {executable_name} kernel clean
    {executable_name} kernel tag
    {executable_name} kernel install
    {executable_name} kernel uninstall
    {executable_name} kernel running
"""

import re
from os.path import exists

import env
from shell import shell, shell_output

linux_source = env.linux_source()
linux_config = env.linux_config()

def _make_in_linux_source(command, sudo=False):
    shell('sudo ' if sudo else '' + 'make -C {} {}'.format(linux_source, command))

def get():
    # Get kernel source from Debian repository
    shell('sudo apt-get install -y linux-source')
    shell('mkdir -p ' + linux_source)
    # Extract to ~/linux-source
    shell('tar -x -f /usr/src/linux-source-* --strip 1 -C ' + linux_source, shell=True)

def config(config_name):
    shell('cp {}/{}.config {}/.config'.format(linux_config, config_name, linux_source))
    shell('khack kernel clean')

    # Answer potential new config questions with yes. If you see this happening
    # you might want to update khack or modify .config yourself
    _make_in_linux_source('olddefconfig')

def make():
    # Showtime, build kernel. Yeah, that's really it
    _make_in_linux_source('-j8')

    # Build initrd/initramfs too so we can boot this kernel. We need to know the
    # exact kernel version for this
    kernel_version = shell_output('cd {} && make kernelversion'.format(linux_source))
    shell('sudo mkinitramfs -v -o {}/arch/x86/boot/initrd {}-khack'.format(linux_source, kernel_version))

def run():
    # Run the built kernel using kexec, skipping a full reboot
    shell('sudo /sbin/kexec -l {}/arch/x86/boot/bzImage --initrd={}/arch/x86/boot/initrd --reuse-cmdline -f'.format(
        linux_source, linux_source))

def clean():
    _make_in_linux_source('clean')

def tag():
    _make_in_linux_source('tags')

def install():
    # Build the module directories in /lib/modules, then install the kernel image
    # and boot filesystem, etc to /boot
    _make_in_linux_source('modules_install install', sudo=True)
    # Compile the VBox Guest Additions against the new kernel and install to /lib/modules,
    # otherwise we won't be able to access VBox shares with the new kernel
    shell('sudo KERN_DIR={} /usr/lib/x86_64-linux-gnu/VBoxGuestAdditions/vboxadd setup'.format(linux_source))

def uninstall():
    shell('sudo rm -r /lib/modules/*-khack')
    shell('sudo rm /boot/*-khack*')
    shell('sudo update-grub')

def running():
    if not exists('{}/.version'.format(linux_source)):
        print u'\033[91m\u2716 There is no .version file.'
        exit(1)

    proc_version = shell_output('cat /proc/version')
    proc_version_email = re.search('\((.+?@.+?)\)', proc_version).group(1)
    proc_version_number = re.search('#([0-9]+)', proc_version).group(1)

    compiled_version_number = shell_output('cat {}/.version'.format(linux_source))

    if 'vagrant' in proc_version_email:
        if compiled_version_number != proc_version_number:
            print u'\033[91m\u2716 The kernel is not up to date.'
        else:
            print u'\033[92m\u2714 The kernel is up to date.'
    elif 'debian' in proc_version_email:
        print u'\033[91m\u2716 The running kernel seems to be the stock Debian kernel.'
    else:
        print u'\033[91m\u2716 I don\'t recognize this kernel.'
