@echo off

echo Setting up docker-machine default

docker-machine create default
docker-machine start
docker-machine env

@for /f "usebackq tokens=*" %%a in (`docker-machine ip`) do set DOCKER_IP=%%a

