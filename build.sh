#!/bin/bash
#BOOTLOADER=${BOOTLOADER:-grub}
#DIR=${DIR:-/output}
#TOTAL_SIZE=${TOTAL_SIZE:-2GB}
#EFI_SIZE=${EFI_SIZE:-261MiB}
#LABEL=${LABEL:-rootfs}

export COMPOSE_FILE=docker-compose.bootloader.yml:docker-compose.distro.yml:docker-compose.disk.yml
#export COMPOSE_PROFILES=grub,ubuntu
#docker-compose config
docker-compose build

export COMPOSE_FILE=docker-compose.bootloader.yml:docker-compose.distro.yml
docker-compose up --remove-orphans
docker export --output ./output/rootfs.tar $(docker-compose ps -q)
docker-compose down

export COMPOSE_FILE=docker-compose.disk.yml
docker-compose up --remove-orphans
docker-compose down

#sudo qemu-system-x86_64 -m 2048M -bios /usr/share/ovmf/OVMF.fd -device virtio-blk-pci,drive=disk0,bootindex=0 -drive id=disk0,if=none,format=raw,file=./output/disk.img