#!/bin/bash

docker exec $(docker ps --filter name=mc_bedrock* --quiet) /usr/local/bin/send-command $1
