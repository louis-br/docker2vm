#!/bin/bash
export COMPOSE_FILE=docker-compose.boot.yml:docker-compose.setup.yml:docker-compose.disk.yml
docker-compose build

export COMPOSE_FILE=docker-compose.boot.yml:docker-compose.setup.yml
docker-compose up --remove-orphans
docker export --output ./output/rootfs.tar $(docker-compose ps ubuntu -q)
docker-compose down

export COMPOSE_FILE=docker-compose.disk.yml
docker-compose up --remove-orphans
docker-compose down

#sudo qemu-system-x86_64 -m 2048M -bios /usr/share/ovmf/OVMF.fd -device virtio-blk-pci,drive=disk0,bootindex=0 -drive id=disk0,if=none,format=raw,file=./output/disk.img