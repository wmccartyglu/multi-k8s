docker build -t wmccarty/multi-client:latest -t wmccarty/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wmccarty/multi-server:latest -t wmccarty/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wmccarty/multi-worker:latest -t wmccarty/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push wmccarty/multi-client:latest
docker push wmccarty/multi-server:latest
docker push wmccarty/multi-worker:latest
docker push wmccarty/multi-client:$SHA
docker push wmccarty/multi-server:$SHA
docker push wmccarty/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wmccarty/multi-server:$SHA
kubectl set image deployments/client-deployment client=wmccarty/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wmccarty/multi-worker:$SHA