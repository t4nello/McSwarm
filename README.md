
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
docker stack deploy proxy --compose-file management-compose.yml  
```

Login to Portainer and setup the new password http:<ip>/Portainer, then deploy other stacks




