docker build -t zdend/k8s-2-client:latest -t zdend/k8s-2-client:$SHA -f ./client/Dockerfile ./client
docker build -t zdend/k8s-2-server:latest -t zdend/k8s-2-server:$SHA -f ./server/Dockerfile ./server
docker build -t zdend/k8s-2-worker:latest -t zdend/k8s-2-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zdend/k8s-2-client:latest
docker push zdend/k8s-2-server:latest
docker push zdend/k8s-2-worker:latest

docker push zdend/k8s-2-client:$SHA
docker push zdend/k8s-2-server:$SHA
docker push zdend/k8s-2-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=zdend/k8s-2-client:$SHA
kubectl set image deployments/server-deployment server=zdend/k8s-2-server:$SHA
kubectl set image deployments/worker-deployment worker=zdend/k8s-2-worker:$SHA

