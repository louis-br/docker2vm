#!/bin/bash
sudo qemu-system-x86_64 -m 2048M -bios /usr/share/ovmf/OVMF.fd -device virtio-blk-pci,drive=disk0,bootindex=0 -drive id=disk0,if=none,format=raw,file=./output/disk.img
