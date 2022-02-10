#!/bin/sh
DIR=${DIR:-$PWD}
TOTAL_SIZE=${TOTAL_SIZE:-3G}
EFI_SIZE=${EFI_SIZE:-261MiB}
LABEL=${LABEL:-rootfs}
dd if=/dev/zero of="$DIR/disk.img" bs=1 count=0 seek="$TOTAL_SIZE" status=progress
parted --script "$DIR/disk.img" \
    mklabel gpt \
    mkpart "$EFI_SIZE" fat32 1MiB "$EFI_SIZE" \
    set 1 esp on \
    mkpart "$LABEL" ext4 "$EFI_SIZE" 100% \
    unit B print