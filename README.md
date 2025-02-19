
# MCSwarm

A set of stacks to deploy minecraft server on linux OS with:
- Node Exporter
- Prometheus
- Grafana
- Traefik
- Portainer
- Portainer Agent

Minecraft server is based on the JDK 21 image 

## Prerequisites

To propelly setup the swarm cluster you have to install docker engine accoring to the instructions on https://docs.docker.com/engine/install/, afer installation follow the steps on https://docs.docker.com/engine/install/linux-postinstall/ .

Install ```apache2-utils``` package to generate password for Traefik 



## Installation

1. Initialize swarm node and create all needed network interfaces

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
Parameter <port> is used to set the port for minecraft server. Alloved values are 0-65535. If parameter is empty, default 25565 will be used
```bash
chmod +x deploy.sh
./deploy.sh  <port>
```


Login to Portainer ```http:<ip>/portainer``` then deploy other stacks

Before deployment the Minecraft server stack it is necessary to create folder on your machine with all neccesary files needed to run minecraft server like server.jar and eula.txt, then pass te proper values into the right environment variables. During first startup of the stack, if all variables are passed correctly, all neccesary files like server.properites, world etc. will be created. After that you can stop the stack and modify your server and run it again.

## Environment Variables

<<<<<<< HEAD
| Parameter           | Description                                                    | Example Value                              | Stack             |
| :-------------------| :--------------------------------------------------------------| :------------------------------------------|-------------------|
| `XMS`               | **Required** Min RAM for Java heap size in megabytes           | 8192m                                      | Server-Stack      |
| `XMX`               | **Required** MAX RAM for Java heap size in megabytes           | 10240m                                     | Server-Stack      |
| `SERVER_DIR`        | **Required** Directory where the server files are located      | /home/t4nello/server                       | Server-Stack      |
| `SERVER_PORT`       | **Required** Port on which the server will run (Default 25565) | 2137                                       | Server-Stack      |
| `JAR_FILE`          | **Required** Name of the JAR file for the server               | server.jar                                 | Server-Stack      |

=======
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
>>>>>>> 4438921ef8c58b8974fa47614d57eb23827761c2

## Endpoints

All endpoint begins with IP address of the server

- **`/traefik/dashboard/`** - Traefik dashboard (The trailing slash is mandatory!)
- **`/grafana`** - Grafana dashboard
- **`/portainer`** - Portainer administration panel
- **`/prometheus`** - Prometheus panel
## Dashboard

This project uses a dashboard based on the [Node Exporter Full](https://grafana.com/grafana/dashboards/1860-node-exporter-full/) from Grafana Labs.

