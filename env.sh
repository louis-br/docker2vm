#!/bin/bash
set -a
DIR=${DIR:-./output}
LABEL=${LABEL:-rootfs}
BOOTLOADER=${BOOTLOADER:-grub}
DISTRO=${DISTRO:-alpine}
TOTAL_SIZE=${TOTAL_SIZE:-2GB}
EFI_SIZE=${EFI_SIZE:-261MiB}
UUID=${UUID:-dddddddd-0000-cccc-eeee-222222222222}
. ./distros/${DISTRO}/kernel.sh