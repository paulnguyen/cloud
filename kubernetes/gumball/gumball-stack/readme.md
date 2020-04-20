

# Go Gumball Sample Stack on Kubernetes

kubectl create -f kubernetes-namespace.yaml
kubectl create -f kubernetes-dashboard.yaml
kubectl get pods --namespace=kube-system
kubectl port-forward <dashboard-pod> 8443:8443 --namespace=kube-system


# Kubernetes Localhost

## Mongo

kubectl create -f mongo-pod.yaml
kubectl get pods --namespace gumball mongo
kubectl exec  --namespace gumball -it mongo -- /bin/bash

kubectl create -f mongo-service.yaml
kubectl get --namespace gumball services

-- Gumball MongoDB Collection (Create Document)

Database Name: cmpe281
Collection Name: gumball

> docker exec -it mongodb bash 
> mongo

use cmpe281
show dbs

db.gumball.insert(
    { 
      Id: 1,
      CountGumballs: NumberInt(281),
      ModelNumber: 'M102988',
      SerialNumber: '1234998871109' 
    }
) ;

-- Gumball MongoDB Collection - Find Gumball Document

db.gumball.find( { Id: 1 } ) ;


## RabbitMQ

kubectl create -f rabbitmq-pod.yaml
kubectl get pods --namespace gumball rabbitmq
kubectl exec  --namespace gumball -it rabbitmq -- /bin/bash

kubectl create -f rabbitmq-service.yaml
kubectl get --namespace gumball services

-- RabbitMQ Create Queue:  

Queue Name: gumball
Durable:	no

> rabbitmqadmin declare queue name=gumball durable=false
> rabbitmqadmin list queues vhost name node messages 


## Gumball API

kubectl create -f gumball-deployment.yaml --save-config 
kubectl get --namespace gumball deployments
kubectl get pods --namespace gumball -l name=gumball
kubectl exec  --namespace gumball -it <pod> -- /bin/bash

kubectl create -f gumball-service.yaml
kubectl get --namespace gumball services

curl localhost:3000/ping
curl localhost:3000/gumball

test-place-order:
	curl -X POST \
  	http://localhost:3000/order \
  	-H 'Content-Type: application/json'

test-order-status:
	curl -X GET \
  	http://localhost:3000/order \
  	-H 'Content-Type: application/json'

test-process-order:
	curl -X POST \
  	http://localhost:3000/orders \
  	-H 'Content-Type: application/json'

export host=<public-ip>

curl $host:9000/ping
curl $host:9000/gumball

export host=<public-ip>

test-place-order:
	curl -X POST \
  	http://$host:9000/order \
  	-H 'Content-Type: application/json'

test-order-status:
	curl -X GET \
  	http://$host:9000/order \
  	-H 'Content-Type: application/json'

test-process-order:
	curl -X POST \
  	http://$host:9000/orders \
  	-H 'Content-Type: application/json'



# Kubernetes on GKE

* https://cloud.google.com/solutions/using-gcp-services-from-gke

-- Install MongoDB (From Marketplace)

* https://console.cloud.google.com/marketplace/details/bitnami-launchpad/mongodb




-- Install RabbitMQ (From Marketplace)

* https://console.cloud.google.com/marketplace/details/google/rabbitmq









