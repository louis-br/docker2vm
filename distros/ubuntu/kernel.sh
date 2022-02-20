#!/bin/bash
set -a
VMLINUZ=/boot/vmlinuz
INITRAMFS=/boot/initrd.img
KERNEL_PARAMETERS="console=ttyS0 rootfstype=ext4 root=/dev/vda2 init=/bin/sh ${KERNEL_PARAMETERS}"