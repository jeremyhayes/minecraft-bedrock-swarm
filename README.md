# minecraft-bedrock-swarm

Home/personal Minecraft server configuration.

## Getting Started

On a machine with [Docker swarm](https://docs.docker.com/engine/swarm/) enabled, deploy the stack
```sh
./deploy.sh
```

The following folders are created:
- `/opt/apps/minecraft/server` - holds the server data
- `/opt/apps/minecraft/backups` - holds server backup data

The following services are created:
- `mc_bedrock` - the Minecraft Bedrock server
- `mc_backup` - daily backup and check for server updates
- `mc_update` - daily check for server updates (currently unused)
- `mc_cron` - crontab service to execute services on a schedule

## Backups

The `mc_backup` service is configured to run daily. This will perform the following:
- Scale the `mc_bedrock` service to 0 instances (stop Minecraft)
- Create a `*.tar.gz` of each world's data
- Scale the `mc_bedrock` service to 1 instance (start Minecraft)
  - The [`itzg/docker-minecraft-bedrock-server`](https://github.com/itzg/docker-minecraft-bedrock-server) image checks for new updates on startup.

## Cleanup

To remove all services:
```sh
./undeploy.sh
```

This will remove all docker services, but leave the data in `/opt/apps/minecraft/...`.
