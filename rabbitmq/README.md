
## RabitMQ & Integration Patterns

	https://www.rabbitmq.com/
	http://www.rabbitmq.com/documentation.html
	http://www.rabbitmq.com/getstarted.html
	http://www.enterpriseintegrationpatterns.com/
	

## Run RabbitMQ Container

    Installing RabbitMQ
    ===================

        https://hub.docker.com/_/rabbitmq/

        docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 -p 4369:4369 -p 5672:5672 rabbitmq:3-management

        https://www.rabbitmq.com/management.html
        https://www.rabbitmq.com/networking.html

        Admin Console Runs on Port: 8080            (for administrative console - default user/pass: guest/guest)
        RabbitMQ Default Listening Port: 5672       (for application clients)
        RabbitMQ EPMD Port: 4369                    (for internal node communications)


    RabbitMQ Hello Example
    ======================
    
        https://github.com/cloudnativego/rabbit-hello
        
        go get github.com/streadway/amqp

        https://github.com/cloudnativego/rabbit-hello/blob/master/receive.go
        https://github.com/cloudnativego/rabbit-hello/blob/master/send.go
	
