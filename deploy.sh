git git restore --staged service-account.json
docker build -t 142122/complex-client:latest -t 142122/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t 142122/complex-server:latest -t 142122/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t 142122/complex-worker:latest -t 142122/complex-worker:$SHA -f ./worker/Dockerfile ./worker
docker push 142122/complex-client:latest
docker push 142122/complex-server:latest
docker push 142122/complex-worker:latest

docker push 142122/complex-client:$SHA
docker push 142122/complex-server:$SHA
docker push 142122/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=142122/complex-server:$SHA
kubectl set image deployments/client-deployment client=142122/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=142122/complex-worker:$SHA

