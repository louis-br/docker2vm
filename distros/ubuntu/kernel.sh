#!/bin/bash
set -a
VMLINUZ=/boot/vmlinuz
INITRAMFS=/boot/initrd.img
KERNEL_PARAMETERS="console=ttyS0 console=tty0 rootfstype=ext4 root=UUID=${UUID} init=/bin/sh ${KERNEL_PARAMETERS}"