#!/bin/bash
. ./env.sh

BOOTLOADER_PATH="bootloaders/${BOOTLOADER}/docker-compose.yml"
DISTRO_PATH="distros/${DISTRO}/docker-compose.yml"
export COMPOSE_FILE=docker-compose.base.yml:docker-compose.disk.yml:${BOOTLOADER_PATH}:${DISTRO_PATH}
docker-compose build || exit 1

export COMPOSE_FILE=docker-compose.base.yml:${BOOTLOADER_PATH}
docker-compose up --remove-orphans || exit 1
#docker-compose down
export COMPOSE_FILE=docker-compose.base.yml:${DISTRO_PATH}
docker-compose up --remove-orphans || exit 1
docker export --output ./output/rootfs.tar $(docker-compose ps -q) || exit 1
#docker-compose down

export COMPOSE_FILE=docker-compose.disk.yml
docker-compose up --remove-orphans || exit 1
#docker-compose down