#!/bin/sh

SCRIPT_DIR=$(dirname -- "$0")

docker stack rm mc
docker volume rm mc_server-data
docker volume rm mc_backups-data
