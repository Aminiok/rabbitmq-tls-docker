# rabbitmq-tls-docker

## Step #1 - Generate TLS files:
`./generate-tls.sh`

This will generate all the TLS files required for the RabbitMQ server and the clients.

## Step #2 - Build the Docker image:
`docker build . -t rabbitmq-ssl:4.0.2`

This will build a the rabbitmq-ssl:4.0.2 docker image.

## Step #3 - Run the RabbitMQ Container:
`docker run -d   --name rabbitmq-2   -p 5671:5671   -p 15674:15672   -v /root/cert/:/home/cert/:Z --user root localhost/rabbitmq-ssl:4.0.2`

This will run the RabbitMQ docker container, and map the generated cer directory to the container. 
