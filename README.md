# docker-zookeeper

Dockerfile for [Apache Zookeeper](https://zookeeper.apache.org/)

Docker images built from this Dockerfile are available from
[Docker Hub](https://hub.docker.com/r/b9company/zookeeper/)

## Usage

```
docker run -ti b9company/zookeeper:3.4.10
```

## Image Information

### Volumes

The Docker image comes with three volumes which Zookeeper uses for storing
database snapshots and transaction logs.

| Volume                      | Description |
| --------------------------- | ----------- |
| `/var/lib/zookeeper`        | `dataDir` configuration parameter. Location where ZooKeeper stores the in-memory database snapshots. |
| `/var/log/zookeeper`        | `dataLogDir` configuration parameter. Location where Zookeeper writes the transaction log. |

**Note:** to maximize throughput and avoid competition between logging and
snapshots, it is highly recommended to dedicate a log device for `dataLogDir`
and make sure `dataDir` does not reside on that device.

### Exposed Ports

| Port | Description |
| ---- | ----------- |
| 2181 | The port to listen for client connections. |
| 2888 | *Replicated mode*. The port for peers to communicate. |
| 3888 | *Replicated mode*. The port to elect the leader. |

## Build Notes

The Docker image can be tailored through variables during the build process.
Note that `ZOOKEEPER_VERSION` is the only one required variable in order to
specify which Zookeeper version to build.

| Makefile Variable      | Description |
| ---------------------- | ----------- |
| `ZOOKEEPER_VERSION`    | **Mandatory**. Zookeeper version to build. |
| `ZOOKEEPER_MIRROR`     | *Optional*. Mirror to use to download Zookeeper. |
| `ZOOKEEPER_ARCHIVE`    | *Optional*. URL to the Zookeeper tarball. In such case, `ZOOKEEPER_MIRROR` is ignored. |
| `ZOOKEEPER_DATADIR`    | *Optional*. dataDir configuration parameter. |
| `ZOOKEEPER_DATALOGDIR` | *Optional*. dataLogDir configuration parameter. |

To build `b9company/zookeeper:3.4.10` Docker image, run:

```
make build ZOOKEEPER_VERSION=3.4.10
```
