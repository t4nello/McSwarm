
# MCSwarm

A set of stacks to deploy minecraft server on linux server OS with Grafana, Prometheus, Traefik, Portainer

## Installation

To deploy this project run

```bash
  docker swarm init --advertise-addr <ip/ifname>
  docker network create --driver overlay --scope swarm monitoring
  docker network create --driver overlay --scope swarm management
  docker network create --driver overlay --scope swarm minecraft
  docker volume create minecraft_server
```
Rename jar-server file to server.jar then copy it with agreed eula txt and optional server.properities to docker-volume

```bash
/var/lib/docker/volumes/minecraft-server/_data
```

Clone the repository and deploy 1st stack with Portainer and Traefik


```bash
git clone https://github.com/t4nello/SwarmStack.git
cd SwarmStack
docker stack deploy proxy --compose-file management-stack.yml  
```

Login to Portainer and setup the new password ```http:<ip>/Portainer```, then deploy other stacks

## Environment Variables
Currently only 1 stack needs to setup environment variables to run, which is the minecraft server stack:

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `XMS` | `string` | **Required** Min RAM for java heap size  in megabytes ex. 1024m |
| `XMX` | `string` | **Required** MAX RAM for java heap size  in megabytes ex. 3096m |


##  TODO

1. setup external volume for prometheus data
2. Add env for path for prometheus.yml path
3. Hide Traefik dashboard behind endpoint
4. SSL certificates?
