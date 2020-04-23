

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

> mongo

use cmpe281
show dbs

db.createUser(
   {
     user: "admin",
     pwd: "cmpe281",  
     roles: [ "readWrite", "dbAdmin" ]
   }
) ;


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


## Mongo

-- Install MongoDB (From Marketplace) into Google Compute Engine VM

* https://console.cloud.google.com/marketplace/details/bitnami-launchpad/mongodb
* https://docs.bitnami.com/google/infrastructure/mongodb/get-started/first-steps/
* https://docs.bitnami.com/google/infrastructure/mongodb/administration/change-reset-password/

1. Click "Launch" from Marketplace
2. Select "cmpe281" Project
3. Set the following options:
  - Deployment Name:  mongodb
  - Machine Type:     micro
  - Boot Disk:        standard persistent disk (10 GB)
  - Networking:       (leave as default cmpe281 network)
4. Click "Deploy"
5. Note the:
  - Admin User:       root
  - Temp Password:    GvTWo8TRnqdi (for example)
6. Go to Compute Engine -> VM Instances
7. Note the "Internal IP Address" 
  - For Example:      10.138.0.9 (Internal IP for MongoDB VM)
8. Connect via SSH


-- Gumball MongoDB Collection (Create Document)

Database Name: cmpe281
Collection Name: gumball

> ssh into instance
> mongo --username root --password --host <host>

> mongo --username root --password --host 10.138.0.9
  (enter temp password from deployment)

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

-- Install RabbitMQ (From Marketplace)

* https://console.cloud.google.com/marketplace/details/google/rabbitmq
* https://www.rabbitmq.com/getstarted.html
* https://github.com/GoogleCloudPlatform/click-to-deploy/blob/master/k8s/rabbitmq/README.md

1. Click "Configure" from Marketplace
2. Select "cmpe281" Project
3. Set the following options:
   - GKE Cluster:               cmpe281
   - GKE Namespace:             default
   - Instance Name:             rabbitmq
   - # of Replicas:             3
   - Username:                  rabbit
   - RabbitMQ Service Account:  (create new one)
4. On GKE Applications for RabbitMQ.  Get Admin User's Password.
   (i.e. Username = rabbit.  Password = 57DfbrYWrh1Z)
5. On GKE Services for RabbitMQ.  Note the Service Name.
   (i.e. RabbitMQ Service Name = rabbitmq-rabbitmq-svc)

-- Open Up Access to RabbitMQ Service

kubectl patch service/rabbitmq-rabbitmq-svc \
  --namespace default \
  --patch '{"spec": {"type": "LoadBalancer"}}'

open http://<external-ip>:15672


-- RabbitMQ Create Queue:  

Queue Name: gumball
Durable:  no

Web Portal:

open http://<external-ip>:15672
create new transient queue named "gumball"

Command Line:

> rabbitmqadmin declare queue name=gumball durable=false
> rabbitmqadmin list queues vhost name node messages 


## Setup GKE Firewall Rule to Allow Pods access to VMs

* https://cloud.google.com/kubernetes-engine/docs/troubleshooting#autofirewall
* https://cloud.google.com/sdk/gcloud/reference/compute/firewall-rules/create

-- Create Firewall Rule 

1. Find your cluster's network:
   
   > gcloud container clusters describe cmpe281 --zone us-central1-c --format=get"(network)"
   > cmpe281

2. Then get the cluster's IPv4 CIDR used for the containers:

   > gcloud container clusters describe cmpe281 --zone us-central1-c --format=get"(clusterIpv4Cidr)"
   > 10.16.0.0/14

3. Finally create a firewall rule for the network, with the CIDR as the source range, 
   and allow all protocols:

   > gcloud compute firewall-rules create "cmpe281-to-all-vms-on-network" --network="cmpe281" --source-ranges="10.16.0.0/14" --allow=tcp:27017

   > Creating firewall...done.
   > NAME                           NETWORK  DIRECTION  PRIORITY  ALLOW       DENY  DISABLED
   > cmpe281-to-all-vms-on-network  cmpe281  INGRESS    1000      tcp:27017         False


## Setup GKE Namespace

kubectl create -f kubernetes-namespace.yaml


## Setup GKE Jumpbox 

* https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

kubectl create --namespace gumball -f jumpbox.yaml
kubectl exec  --namespace gumball -it jumpbox  -- /bin/bash

apt-get update
apt-get install curl
apt-get install iputils-ping
apt-get install python3

curl -Ls https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/v3.8.3/bin/rabbitmqadmin > rabbitmqadmin
chmod +x rabbitmqadmin
ln -s /usr/bin/python3 /usr/bin/python


## Test MongoDB & RabbitMQ Connectivity from Jumpbox

kubectl exec  --namespace gumball -it jumpbox  -- /bin/bash

mongo --username root --password --host 10.138.0.9
(Temp Password: GvTWo8TRnqdi)

rabbitmqadmin -u rabbit -p 57DfbrYWrh1Z -H 10.81.9.66 -P 15672 list queues name node messages
(Connect using RabbitMQ Cluster IP)


## Gumball API

kubectl create -f gumball-deployment.yaml --save-config 
kubectl get --namespace gumball deployments

kubectl exec  --namespace gumball -it <deployment-pod>  -- /bin/bash

kubectl exec  --namespace gumball -it gumball-deployment-6f7648f6b8-fsj47  -- /bin/bash
kubectl logs --namespace gumball gumball-deployment-6f7648f6b8-fsj47
    
curl localhost:3000/ping
curl localhost:3000/gumball

kubectl create -f gumball-service.yaml
kubectl get --namespace gumball services

- Test Against Service Public IP

export host=<public-id>

curl $host:9000/ping
curl $host:9000/gumball

curl -X POST \
  http://$host:3000/order \
  -H 'Content-Type: application/json'

curl -X GET \
  http://$host:3000/order \
  -H 'Content-Type: application/json'

curl -X POST \
  http://$host:3000/orders \
  -H 'Content-Type: application/json'





