#!/bin/sh

SCRIPT_DIR=$(dirname -- "$0")

mkdir -p /opt/apps/minecraft/server
mkdir -p /opt/apps/minecraft/backups

docker stack deploy -c "$SCRIPT_DIR/docker-compose.yml" mc
