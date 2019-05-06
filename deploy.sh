docker build -t mozyk27/multi-client:latest -t mozyk27/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mozyk27/multi-server:latest -t mozyk27/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mozyk27/multi-worker:latest -t mozyk27/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mozyk27/multi-client:latest
docker push mozyk27/multi-server:latest
docker push mozyk27/multi-worker:latest

docker push mozyk27/multi-client:$SHA
docker push mozyk27/multi-server:$SHA
docker push mozyk27/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mozyk27/multi-server:$SHA
kubectl set image deployments/client-deployment client=mozyk27/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mozyk27/multi-worker:$SHA
