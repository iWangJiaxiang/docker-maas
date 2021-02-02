# docker-maas

Docker image for Ubuntu MaaS



## 使用

```bash
docker run -it \
    --name=ubuntu-maas \
    -d \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    -v $PWD/data:/var/lib/postgresql/ \
    --privileged \
    -p 5240:5240 \
    wangjiaxiang/maas:dev
docker exec -it ubuntu-maas bash
```



### 端口

| 端口 | 协议 | 描述   |
| ---- | ---- | ------ |
| 53   | udp  | DNS    |
| 5240 | tcp  | Web UI |
| 67   | udp  | DHCP   |
| 69   | udp  | TFTP   |



### 宿主机资源

- `/sys/fs/cgroup`

### 数据持久化

配置文件



数据库

`/var/lib/postgresl/`

镜像

## 开发

The following resources might be useful for contributors

- [Play with Docker](https://labs.play-with-docker.com/)