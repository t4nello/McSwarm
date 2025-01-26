#!/bin/bash

if [ -z "$1" ]; then
  PORT=25565
else
  PORT=$1
fi

# Sprawdzenie, czy podany port jest liczbą z zakresu 0-65535
if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 0 ] || [ "$PORT" -gt 65535 ]; then
  echo "Error: Port number must be an integer from range 0-65535"
  exit 1
fi


echo "MINECRAFT_SERVER_PORT=$PORT" > ./managament/managament-stack.env

echo "Minecraft server port is set to: $PORT"


export $(cat ./managament/managament-stack.env | xargs)


processed="./managament/managament-stack-processed.yml"
docker stack config --compose-file ./managament/managament-stack.yml > "$processed"


docker stack deploy --compose-file "$processed" managament-stack
