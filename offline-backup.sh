#!/bin/sh

#SERVER_DIR=/opt/apps/minecraft/server
SERVER_DIR=${SERVER_DIR:?required}

#BACKUP_DIR=/opt/apps/minecraft/backups
BACKUP_DIR=${BACKUP_DIR:?required}

#SERVICE_NAME=mc_bedrock
SERVICE_NAME=${SERVICE_NAME:?required}

DATE_FMT="%Y-%m-%d_%H-%M-%S"

echo "Stopping bedrock service..."
docker service scale $SERVICE_NAME=0

for world_dir in $SERVER_DIR/worlds/*; do
  world_name=$(basename "$world_dir")
  target="$BACKUP_DIR/$world_name-$(date +$DATE_FMT).tar.gz"
  echo "Backing up '$world_name' to $target..."
  tar -cvpzf "$target" "$world_dir"

  echo "Cleaning up old versions of '$world_name'..."
  find "$BACKUP_DIR" -name "$world_name-*.tar.gz" -type f -mtime +14 -print -delete
done

echo "Starting bedrock service..."
docker service scale $SERVICE_NAME=1
