#!/usr/bin/python

"""KernelTLV Linux Hacking Utility

Usage:
    {executable_name} module make
    {executable_name} module clean
    {executable_name} module install
"""

import env
from shell import shell

linux_source = env.linux_source()

def make():
    shell('make M=../module -C {} -j8'.format(linux_source))

def clean():
    shell('make M=../module -C {} clean'.format(linux_source))

def install():
    # Not implemented yet
    pass
