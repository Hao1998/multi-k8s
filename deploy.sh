docker build -t 142122/complex-client:latest -t 142122/complex-client:$VERSION -f ./client/Dockerfile ./client
docker build -t 142122/complex-server:latest -t 142122/complex-server:$VERSION -f ./server/Dockerfile ./server
docker build -t 142122/complex-worker:latest -t 142122/complex-worker:$VERSION -f ./worker/Dockerfile ./worker
docker push 142122/complex-client:latest
docker push 142122/complex-server:latest
docker push 142122/complex-worker:latest

docker push 142122/complex-client:$VERSION
docker push 142122/complex-server:$VERSION
docker push 142122/complex-worker:$VERSION

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=142122/complex-server:$VERSION
kubectl set image deployments/client-deployment client=142122/complex-client:$VERSION
kubectl set image deployments/worker-deployment worker=142122/complex-worker:$VERSION

