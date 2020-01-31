#!/bin/bash
NAME=jupyter

docker build -t $NAME:1.0 .
docker stop $NAME || true
docker rm -f $NAME || true
docker run -d --name $NAME --restart always --env-file /root/env -p 9999:9999 $NAME:1.0