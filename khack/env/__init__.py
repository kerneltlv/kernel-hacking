import os

def linux_config():
    return os.getenv('KHACK_LINUX_CONFIG_DIR','/home/vagrant/linux-config')

def linux_source():
    return os.getenv('KHACK_LINUX_SOURCE_DIR','/home/vagrant/linux-source')

def libc_source():
    return os.getenv('KHACK_LIBC_SOURCE_DIR','/home/vagrant/glibc-source')
