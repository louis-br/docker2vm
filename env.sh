#!/bin/bash
set -a
DIR=${DIR:-./output}
LABEL=${LABEL:-rootfs}
BOOTLOADER=${BOOTLOADER:-grub}
DISTRO=${DISTRO:-alpine}
TOTAL_SIZE=${TOTAL_SIZE:-2GB}
EFI_SIZE=${EFI_SIZE:-261MiB}
COMPOSE_PROFILES=${BOOTLOADER},${DISTRO}
. ./distros/${DISTRO}/kernel.sh