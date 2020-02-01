#!/bin/bash
NAME=jupyter

docker build -t $NAME:1.0 .
docker stop $NAME || true
docker rm -f $NAME || true
docker run -d --name $NAME --restart always -e PYTHONUNBUFFERED=0 -e TZ=America/Sao_Paulo -p 9999:9999 $NAME:1.0
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)