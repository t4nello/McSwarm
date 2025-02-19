#!/bin/bash

if ! command -v htpasswd &> /dev/null; then
  echo "Error: 'htpasswd' command not found. Install 'apache2-utils' (Debian/Ubuntu) or 'httpd-tools' (RHEL/CentOS) and try again."
  exit 1
fi


if [ ! -f "./managament/usersfile" ]; then
  echo "Error: 'usersfile' has not been found."
  echo "Create it using:"
  echo "  htpasswd -Bc -C 6 ./managament/usersfile <username>"
  echo "Then try deployment again."
  exit 1
fi

if [ -z "$1" ]; then
  PORT=25565
else
  PORT=$1
fi


if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 0 ] || [ "$PORT" -gt 65535 ]; then
  echo "Error: Port number must be an integer from range 0-65535"
  exit 1
fi

echo "MINECRAFT_SERVER_PORT=$PORT" > ./managament/managament-stack.env

echo "Minecraft server port is set to: $PORT"


export $(cat ./managament/managament-stack.env | xargs)


processed="./managament/managament-stack-processed.yml"
docker stack config --compose-file ./managament/managament-stack.yml > "$processed"


docker swarm init 2>/dev/null || echo "Swarm already initialized."


docker network create --driver overlay --scope swarm monitoring 2>/dev/null || echo "Network 'monitoring' already exists."
docker network create --driver overlay --scope swarm management 2>/dev/null || echo "Network 'management' already exists."
docker network create --driver overlay --scope swarm minecraft 2>/dev/null || echo "Network 'minecraft' already exists."

docker stack deploy --compose-file "$processed" managament-stack
