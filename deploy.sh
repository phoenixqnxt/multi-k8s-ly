docker build -t phoenixqnxt/multi-client-ly:latest -t phoenixqnxt/multi-client-ly:$SHA -f ./client/Dockerfile ./client
docker build -t phoenixqnxt/multi-server-ly:latest -t phoenixqnxt/multi-server-ly:$SHA -f ./server/Dockerfile ./server
docker build -t phoenixqnxt/multi-worker-ly:latest -t phoenixqnxt/multi-worker-ly:$SHA -f ./worker/Dockerfile ./worker

docker push phoenixqnxt/multi-client-ly:latest
docker push phoenixqnxt/multi-server-ly:latest
docker push phoenixqnxt/multi-worker-ly:latest

docker push phoenixqnxt/multi-client-ly:$SHA
docker push phoenixqnxt/multi-server-ly:$SHA
docker push phoenixqnxt/multi-worker-ly:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=phoenixqnxt/multi-client-ly:$SHA
kubectl set image deployments/server-deployment server=phoenixqnxt/multi-server-ly:$SHA
kubectl set image deployments/worker-deployment worker=phoenixqnxt/multi-worker-ly:$SHA
