#!/usr/bin/env bash

docker stack deploy -f docker-compose.yml -f docker-compose.override.yml knit