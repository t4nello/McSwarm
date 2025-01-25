
# MCSwarm

A set of stacks to deploy minecraft server on linux OS with:
- Node Exporter
- Prometheus
- Grafana
- Traefik
- Portainer
- Portainer Agent

Server stack is based on the JDK 21 image 

## Prerequisites

To propelly setup the swarm cluster you have to install docker engine accoring to the instructions on https://docs.docker.com/engine/install/, afer installation follow the steps on https://docs.docker.com/engine/install/linux-postinstall/ .

Install ```apache2-utils``` package to generate password for Traefik 



## Installation

1. Create all needed network interfaces

```bash
  docker swarm init --advertise-addr <ip/ifname>
  docker network create --driver overlay --scope swarm monitoring
  docker network create --driver overlay --scope swarm management
  docker network create --driver overlay --scope swarm minecraft
```

2. Clone the repository

3. Go to cloned repository folder:

```bash
cd McSwarm
```
4. create username and password for traefik dashboard:

```bash
htpasswd -Bc -C 6 ./managament/usersfile <userame>
```
At this point you will be asked to type then retype password.

5. To deploy the application, you need to grant execute permissions to the deploy script and then run it:
```bash
chmod +x deploy.sh
./deploy.sh
```


Login to Portainer ```http:<ip>/portainer``` then deploy other stacks


## Environment Variables

| Variable                   | Stack      | Required? | Default value                              |
|----------------------------|------------|-----------|--------------------------------------------|
| MINECRAFT_SERVER_PORT      | Managament | No        | 25565                                      |
| MONITORING_CONFIG_PATH     | Monitoring | Yes       |                                            |
| GF_SECURITY_ADMIN_USER     | Monitoring | Yes       |                                            |
| GF_SECURITY_ADMIN_PASSWORD | Monitoring | Yes       |                                            |
| XMS                        | Server     | No        | 1024m                                      |
| XMX                        | Server     | No        | 4098m                                      |
| SERVER_DIR                 | Server     | Yes       |                                            |
| JAR_FILE_NAME              | Server     | Yes       | server.jar                                 |

Example values of the Environment Variables are stored in the `example-env-values` folder

## Endpoints

All endpoint begins with IP address of the server

- **`/dashboard/`** - Traefik dashboard
- **`/grafana`** - Grafana dashboard
- **`/portainer`** - Portainer panel

## Dashboard

This project uses a dashboard based on the [Node Exporter Full](https://grafana.com/grafana/dashboards/1860-node-exporter-full/) from Grafana Labs.

