#!/bin/bash

echo $1 | socat EXEC:"docker attach $(docker ps --filter name=mc_bedrock* --quiet)",pty STDIN
