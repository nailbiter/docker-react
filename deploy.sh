#!/bin/bash

## 1. build all our images, tag each one, push each to dockerhub
## 2. apply all configs in `k8s` folder
## 3. imperatively set latest images on each deployment

## note: very soon will notice a small probelm
## ==> something will be "slightly off" about commands below
## it's not entirely as easy as we'd thought

## 1.
docker build -t nailbiter/multi-client:latest -t nailbiter/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nailbiter/multi-server:latest -t nailbiter/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nailbiter/multi-worker:latest -t nailbiter/multi-worker:$SHA -f ./worker/Dockerfile ./worker

## note: additional benifit of using $SHA -- simplifies debugging
docker push nailbiter/multi-client:latest
docker push nailbiter/multi-server:latest
docker push nailbiter/multi-worker:latest

docker push nailbiter/multi-client:$SHA
docker push nailbiter/multi-server:$SHA
docker push nailbiter/multi-worker:$SHA


## 2.
kubectl apply -f k8s


## 3. (things will start getting interesting here)

## naive approach: 
# > kubectl set image deployments/server-deployment server=nailbiter/multi-server
## problem with 👆:
## * (we spoke about this before -- need to use imperative command)
## * ==> need to tag image with unique tag (will use sha)
## * we omitted it above (see history of this file)
kubectl set image deployments/server-deployment server=nailbiter/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nailbiter/multi-worker:$SHA
kubectl set image deployments/client-deployment client=nailbiter/multi-client:$SHA
