#!/bin/bash

export $(cat ./managament/managament-stack.env | xargs)

processed="./managament/managament-stack-processed.yml"

docker stack config --compose-file ./managament/managament-stack.yml > "$processed"

docker stack deploy --compose-file "$processed" managament-stack