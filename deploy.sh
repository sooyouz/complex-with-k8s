docker build -t sooyouz/multi-client:$GIT_SHA -t sooyouz/multi-client:latest -f ./client/Dockerfile ./client
docker build -t sooyouz/multi-server:$GIT_SHA -t sooyouz/multi-server:latest -f ./server/Dockerfile ./server
docker build -t sooyouz/multi-worker:$GIT_SHA -t sooyouz/multi-worker:latest -f ./worker/Dockerfile ./worker
docker push sooyouz/multi-client:$GIT_SHA
docker push sooyouz/multi-server:$GIT_SHA
docker push sooyouz/multi-worker:$GIT_SHA
docker push sooyouz/multi-client:latest
docker push sooyouz/multi-server:latest
docker push sooyouz/multi-worker:latest

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sooyouz/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=sooyouz/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=sooyouz/multi-worker:$GIT_SHA