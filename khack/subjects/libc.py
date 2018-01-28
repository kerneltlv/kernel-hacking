#!/usr/bin/python

"""KernelTLV Linux Hacking Utility

Usage:
    {executable_name} libc get
"""

import env
from shell import shell

libc_source = env.libc_source()

def get():
    shell('sudo apt-get install -y gawk glibc-source')
    shell('mkdir -p ' + libc_source)
    shell('tar -x -f /usr/src/glibc/glibc-* --strip 1 -C ' + libc_source)
