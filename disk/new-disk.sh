#!/bin/sh
DIR=${DIR:-$PWD}
TOTAL_SIZE=${TOTAL_SIZE:-3G}
EFI_SIZE=${EFI_SIZE:-261MiB}
LABEL=${LABEL:-rootfs}

pack () {
    cat /tmp/partition |
    for i in 1 2; do
        read start size
        if [ "$1" = "extract" ]; then  ipart="" opart="$i" param="skip";
        else                ipart="$i"; opart=""; param="seek"; fi
        echo "IDIR:$IDIR ODIR:$ODIR start:$start size:$size ipart:$ipart opart:$opart param:$param"
        dd if="$IDIR/disk.img$ipart" of="$ODIR/disk.img$opart" bs=4096 $param=$((${start%B}/4096)) count=$((${size%B}/4096)) conv=sync,sparse,noerror,notrunc status=progress
    done
}

copy_to_fat () {
    root=${root:-""}
    for f in "$@"; do
        echo "$PWD/$f -> $root/$f (root: $root)"
        if [ -d "$f" ]; then
            oldroot="$root"
            root="$root/$f"
            mmd -i /disk.img1 "::$root"
            cd "$f"
            copy_to_fat *
            cd ..
            root="$oldroot"
        fi
        if [ -f "$f" ]; then
           mcopy -i /disk.img1 "$f" "::$root"
        fi
    done
}

dd if=/dev/zero of="$DIR/disk.img" bs=1 count=0 seek="$TOTAL_SIZE" status=progress
partition_output=$(parted --script "$DIR/disk.img" \
    mklabel gpt \
    mkpart EFI fat32 1MiB "$EFI_SIZE" \
    set 1 esp on \
    mkpart "$LABEL" ext4 "$EFI_SIZE" 100% \
    unit B print)
echo "$partition_output" | awk '$6=="EFI"||$6=="'"$LABEL"'"{print $2 " " $4}' > /tmp/partition
echo "$partition_output"
#cat /tmp/partition  
IDIR=$DIR ODIR=/ pack "extract"

mkdir /rootfs && cd /rootfs
tar xf /output/rootfs.tar
#rm /output/rootfs.tar
mkfs.ext4 -v -t ext4 -U $UUID -d /rootfs /disk.img2

cd /
mkfs.vfat /disk.img1
copy_to_fat EFI

IDIR=/ ODIR=$DIR pack
sync --file-system output/
#tail -f /dev/null