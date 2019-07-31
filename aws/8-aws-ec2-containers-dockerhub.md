

### AWS EC2 Containers (With Docker Hub)

* https://docs.aws.amazon.com/ecs/index.html
* https://aws.amazon.com/getting-started/tutorials/deploy-docker-containers/
* https://github.com/paulnguyen/cmpe281/tree/master/golabs/gocloud/gumball/goapi/goapi_v1
    
### AWS Container Getting Started

```
    http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_GetStarted.html
    https://us-west-1.console.aws.amazon.com/ecs/home?region=us-west-1#/firstRun
    
    1. Click the "Get Started" Button
           
    2. Create a task definition

            Task Definition Name:       go-api
            Container Name:             go-api
            Image:                      paulnguyen/gumball:goapi-v1
            Memory Limits (Hard):       300 (MBs)
            Port Mappings:
                Host Port               8080
                Container Port          3000
                Protocol                TCP
                
    3.  Configure Service

            Service Name:               go-api
            Desired number of tasks:    1
            Container name (host port): go-api:8080:3000
            Load Balancing:             none
            
    4.  Configure Cluster

            Cluster Name:               go-api
            EC2 instance type:          t2.micro
            Number of instances:        1
            Key Pair:                   cmpe281-us-west-1
            Security Group:             Allowed ingress source: Select "Anywhere"
            Container instance 
                     IAM role:          Auto Create New Role (ecsInstanceRole)
            
    5. View Service

            https://us-west-1.console.aws.amazon.com/ecs/home?region=us-west-1#/clusters/docker/services/go-api/tasks  
            

```     
            
