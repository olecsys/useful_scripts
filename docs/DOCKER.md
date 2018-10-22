# Docker helps
## How to start *bash* from docker
You can do it like this:
```
$ docker run --name <CONTAINER NAME> -it <DOCKER IMAGE> bash
```
## How to stop container
```
$ docker stop <CONTAINER ID>
```
## How to copy from container to host
You can use cp comand when container is running like this:
```
$ docker cp <containerId>:/file/path/within/container /host/path/target
```
## How to get running containers
You can use ls command like this:
```
$ docker container ls 
```
## How to get all containers
You can use ls command like this:
```
$ docker container ls  -a
```
## How to build image from Dockerfile
You need to cd to Dockerfile directory and type this:
```
$ cd <Dockerfile directory>
$ docker build -f <Docker file name> -t <New image name> .
```
## How to list all tags for a Docker image on a remote registry
You can do it like this:
```
$ wget -q https://registry.hub.docker.com/v1/repositories/debian/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'
```
## Remove single image
```
docker rmi image_name:version/image-id
```
## Remove all images
```bash
$ docker rmi $(docker images -q)
```
## Remove all containers
```bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```

