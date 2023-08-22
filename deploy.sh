# docker build -t $DOCKER_ID/multi-client-k8s:latest -t $DOCKER_ID/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
# docker build -t $DOCKER_ID/multi-server-k8s:latest -t $DOCKER_ID/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
# docker build -t $DOCKER_ID/multi-worker-k8s:latest -t $DOCKER_ID/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

# docker push $DOCKER_ID/multi-client-k8s:latest
# docker push $DOCKER_ID/multi-server-k8s:latest
# docker push $DOCKER_ID/multi-worker-k8s:latest

# docker push $DOCKER_ID/multi-client-k8s:$SHA
# docker push $DOCKER_ID/multi-server-k8s:$SHA
# docker push $DOCKER_ID/multi-worker-k8s:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=$DOCKER_ID/multi-server-k8s:latest
kubectl set image deployments/client-deployment client=$DOCKER_ID/multi-client-k8s:latest
kubectl set image deployments/worker-deployment worker=$DOCKER_ID/multi-worker-k8s:latest

# kubectl set image deployments/server-deployment server=$DOCKER_ID/multi-server-k8s:$SHA
# kubectl set image deployments/client-deployment client=$DOCKER_ID/multi-client-k8s:$SHA
# kubectl set image deployments/worker-deployment worker=$DOCKER_ID/multi-worker-k8s:$SHA
