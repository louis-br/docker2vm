#!/bin/bash
#BOOTLOADER=${BOOTLOADER:-grub}
#DIR=${DIR:-/output}
#TOTAL_SIZE=${TOTAL_SIZE:-2GB}
#EFI_SIZE=${EFI_SIZE:-261MiB}
#LABEL=${LABEL:-rootfs}

. ./env.sh
export COMPOSE_FILE=docker-compose.bootloader.yml:docker-compose.distro.yml:docker-compose.disk.yml
docker-compose build

export COMPOSE_FILE=docker-compose.bootloader.yml
docker-compose up --remove-orphans
docker-compose down
export COMPOSE_FILE=docker-compose.distro.yml
docker-compose up --remove-orphans
docker export --output ./output/rootfs.tar $(docker-compose ps -q)
docker-compose down

export COMPOSE_FILE=docker-compose.disk.yml
docker-compose up --remove-orphans
docker-compose down