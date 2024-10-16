
# MCSwarm

A set of stacks to deploy minecraft server on linux server OS with Grafana, Prometheus, Traefik, Portainer

## Prerequisites

To propelly setup the swarm cluster you have to install docker engine accoring to the instructions on ```https://docs.docker.com/engine/install/```, afer installation follow the steps on ```https://docs.docker.com/engine/install/linux-postinstall/``  

## Installation

To deploy this project run

```bash
  docker swarm init --advertise-addr <ip/ifname>
  docker network create --driver overlay --scope swarm monitoring
  docker network create --driver overlay --scope swarm management
  docker network create --driver overlay --scope swarm minecraft
```

Clone the repository and deploy 1st stack with Portainer and Traefik

```bash
git clone https://github.com/t4nello/McSwarm.git
cd McSwarm
docker stack deploy proxy --compose-file management-stack.yml  
```

Login to Portainer and setup the new password ```http:<ip>/Portainer```, then deploy other stacks

## Environment Variables

| Parameter           | Description                                                    | Example Value                              | Stack             |
| :-------------------| :--------------------------------------------------------------| :------------------------------------------|-------------------|
| `XMS`               | **Required** Min RAM for Java heap size in megabytes           | 8192m                                      | Server-Stack      |
| `XMX`               | **Required** MAX RAM for Java heap size in megabytes           | 10240m                                     | Server-Stack      |
| `SERVER_DIR`        | **Required** Directory where the server files are located      | /home/t4nello/server                       | Server-Stack      |
| `SERVER_PORT`       | **Required** Port on which the server will run                 | 2137                                       | Server-Stack      |
| `JAR_FILE`          | **Required** Name of the JAR file for the server               | server.jar                                 | Server-Stack      |
| `PROMETHEUS_CONFIG` | **Required** prometheus.yml config file location               | /home/t4nello/McSwarm/prometheus.yml       | Monitoring-Stack  |
| `GRAFANA_DIR_PATH`  | **Required** path to grafana datasources directory             | /home/t4nello/McSwarm/grafana/             | Monitoring-Stack  |

## Endpoints

All endpoint begins with IP address of the server

- **`/dashboard`** - Traefik dashboard
- **`/grafana`** - Grafana dashboard
- **`/portainer`** - Portainer panel
