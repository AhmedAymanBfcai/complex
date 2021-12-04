# This file to build our images, tag each one, push each to dockerhub.
docker build -t ahmadayman/multi-client:latest -t ahmadayman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahmadayman/multi-server:latest -t ahmadayman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahmadayman/multi-worker:latest -t ahmadayman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ahmadayman/multi-client:latest
docker push ahmadayman/multi-server:latest
docker push ahmadayman/multi-worker:latest

docker push ahmadayman/multi-client:$SHA
docker push ahmadayman/multi-server:$SHA
docker push ahmadayman/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ahmadayman/multi-server:$SHA
kubectl set image deployments/client-deployment client=ahmadayman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ahmadayman/multi-worker:$SHA
