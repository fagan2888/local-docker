## Run Docker using Docker machine

### Setup Docker machine

As Docker is designed to run on Linux it needs to be as a Linux guest virtual
Mmchine on a host running Windows or Mac operating systems.

1. Change to the root directory of the project

  ```
  cd local_docker
  ```

2. Setup Docker default machine

  ```
  docker-default-setup.bat
  ```

3. View the ip address of the default Docker machine

  ```
  echo %DOCKER_IP%
  ```

4. Execute the line below tto setup your environment

  ```
  @FOR /f "tokens=*" %i IN ('docker-machine env') DO @%i
  ```

5. List the shared folder information

  ```
  VBoxManage showvminfo default --machinereadable | grep SharedFolder
  ```

6. Map the current workspace folder to Docker machine if required

  ```
  VBoxManage.exe sharedfolder add default --name /ws --hostpath %cd% --automount
  ```

### Build the workspace container

This container will be used to develop software and run docker commands as
command line tools are better on Linux than on Windows or Mac computers.

1. Change to the Docker workspace

  ```
  cd dkr-ws
  ```

2. List existing docker containers

  ```
  docker images
  ```

3. Build the Ubuntu image

  ```
  docker build . -t my-ubuntu
  ```

4. List running containers

  ```
  docker ps
  ```

5. Run the Docker workspace container

  ```
  docker run -ti --rm --name my-ubuntu -v /ws:/ws -v /var/run/docker.sock:/var/run/docker.sock:ro my-ubuntu
  ```

### Run the Flask and Redis app

This is a simple Flask app that uses Redis to count the number of times the
web page is accessed.

1. Run the Ubuntu container

  ```
  docker run -ti --rm --name my-ubuntu -v /ws:/ws -v /var/run/docker.sock:/var/run/docker.sock:ro my-ubuntu
  ```

2. Change to the flask directory

  ```
  cd /ws/flask
  ```

3. Build the Flask app and other containers

  ```
  docker-compose build
  ```

4. Run the Flask app with the Redis container

  ```
  docker-compose up -d
  ```

5. Open your browser to the address in DOCKER_IP (from Windows)

  ```
  explorer "http://%DOCKER_IP%:5000"
  ```

6. To stop the containers

  ```
  docker-compose stop
  ```

7. To remove the containers

  ```
  docker-compose rm
  ```

### Run the Nginx proxy and whoami app

Using the [nginx-proxy][110] nginx can be automatically used to expose
services running in multiple docker containers as subdomains.

[110]: https://github.com/jwilder/nginx-proxy

1. Run the Ubuntu container

  ```
  docker run -ti --rm --name my-ubuntu -v /ws:/ws -v /var/run/docker.sock:/var/run/docker.sock:ro my-ubuntu
  ```

2. Change to the whoami directory

  ```
  cd /ws/whoami
  ```

3. Build the Nginx proxy and whoami app

  ```
  docker-compose build
  ```

4. Run the Nginx proxy and whoami app

  ```
  docker-compose up -d
  ```

5. Test the proxy using curl

  ```
  curl -H "Host: whoami.local" 192.168.99.100
  ```

6. Test the proxy using httpie

  ```
  http 192.168.99.100 Host:whoami.local
  ```

7. To stop the containers

  ```
  docker-compose stop
  ```

8. To remove the containers

  ```
  docker-compose rm
  ```

### Run Jupyter notebooks

1. Run the Jupyter notebook
docker run -it --rm -p 0.0.0.0:8888:8888 jupyter/minimal-notebook

2. Run the Jupyter lab
docker run -it --rm -p 0.0.0.0:8888:8888 jupyter/minimal-notebook start.sh jupyter lab
