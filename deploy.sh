#!/bin/bash

if [ -z "$1" ]; then
  echo "MINECRAFT_SERVER_PORT=25565" > ./managament/managament-stack.env
fi

if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -lt 0 ] || [ "$1" -gt 65535 ]; then
  echo "Error: Port number must be integer from range 0-65535"
  exit 1
fi

echo "MINECRAFT_SERVER_PORT=$1" > ./managament/managament-stack.env

echo "Port ustawiony na: $1"

export $(cat ./managament/managament-stack.env | xargs)

processed="./managament/managament-stack-processed.yml"
docker stack config --compose-file ./managament/managament-stack.yml > "$processed"

#docker stack deploy --compose-file "$processed" managament-stack

