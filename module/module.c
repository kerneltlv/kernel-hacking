#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

#include "module.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("KernelTLV");
MODULE_DESCRIPTION("A kernel module scaffold");
MODULE_VERSION("0.1");

static int __init init(void)
{
    printk(KERN_INFO "Module loaded!\n");
    return 0;
}

static void __exit exit(void)
{
    printk(KERN_DEBUG "Module unloaded!\n");
}

module_init(init);
module_exit(exit);