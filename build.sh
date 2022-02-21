#!/bin/bash
. ./env.sh

BOOTLOADER_PATH="bootloaders/${BOOTLOADER}/docker-compose.yml"
DISTRO_PATH="distros/${DISTRO}/docker-compose.yml"
export COMPOSE_FILE=docker-compose.base.yml:docker-compose.disk.yml:${BOOTLOADER_PATH}:${DISTRO_PATH}
docker-compose build

export COMPOSE_FILE=docker-compose.base.yml:${BOOTLOADER_PATH}
docker-compose up --remove-orphans
docker-compose down
export COMPOSE_FILE=docker-compose.base.yml:${DISTRO_PATH}
docker-compose up --remove-orphans
docker export --output ./output/rootfs.tar $(docker-compose ps -q)
docker-compose down

export COMPOSE_FILE=docker-compose.disk.yml
docker-compose up --remove-orphans
docker-compose down