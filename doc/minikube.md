## Run Docker using Minikube

### Install Minikube

1. Download minikube from https://github.com/kubernetes/minikube

2. Rename it to minikube.exe and make sure it is in your path

3. Download kubectl using the command

  ```
  curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.7.5/bin/windows/amd64/kubectl.exe
  ```

4. List the kubectl client version

  ```
  kubectl version --client
  ```

5. Display minikube version. Should be 0.21.0 and higher

  ```
  minikube version
  ```

6. Start the minikube cluster

  ```
  minikube start
  ```

7. Display the status of the cluster

  ```
  minikube status
  ```

8. List ip addresss

  ```
  minikube ip
  ```

9. Get minikube Docker information

  ```
  minikube docker-env
  ```

10. Setup Minikube Docker environment

  ```
  @FOR /f "tokens=*" %i IN ('minikube docker-env') DO @%i

  ```

### Create a Kubernetes echo service

1. List existing srevices

  ```
  minikube service list
  ```

2. Create a hello-minikube deployment

  ```
  kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port=8080
  ```

3. Create a service for hello-minikube deployment

  ```
  kubectl expose deployment hello-minikube --type=NodePort
  ```

4. List all services including the new service

  ```
  minikube service list
  ```

5. Check that the hello-minikube deployment has a status of running

  ```
  kubectl get pods
  ```

6. Get the address of the hello-minikube service

  ```
  minikube service hello-minikube --url
  ```

7. Open the browser to the address in the previous step

  ```
  @FOR /f "tokens=*" %i IN ('minikube service hello-minikube --url') DO explorer %i
  ```

8. Clean up service and deployment

  ```
  kubectl delete service,deployment hello-minikube
  ```

9. Shutdown cluster

  ```
  minikube stop
  ```

### Build the flask-kube app

1. Change to the flask-kube directory

  ```
  cd k8s-py/python/flask-kube
  ```

2. Get the latest Python image

  ```
  docker pull python:3.6-jessie
  ```

3. Build the Docker container

  ```
  docker build -t flask-kube:latest .
  ```

4. List images

  ```
  docker images
  ```

4. Run the image and display the version of Python

  ```
  docker run -it --rm flask-kube:latest python -V
  ```

### Share a folder on the minikube VM
1. List the running VMs (should include minikube)

  ```
  VBoxManage list runningvms
  ```

2. List information about the minikube VM

  ```
  VBoxManage showvminfo minikube
  ```

3. List only the shared folder information

  ```
  VBoxManage showvminfo minikube --machinereadable | grep SharedFolder
  ```

4. To share the current folder as ws (may have to run minikube stop)

  ```
  VBoxManage sharedfolder add minikube --name ws --hostpath %cd% --automount
  ```

5. To remove the shared folder type

  ```
  VBoxManage sharedfolder remove minikube --name ws
  ```

### Create a requirements.txt file for Python libraries

1. Run the docker container by mounting a local folder

  ```
  docker run -it --rm -v /ws:/ws flask-kube bash
  ```

2. Change to the current directory mapped into the container

  ```
  cd /ws
  ```

3. Install software you want and create a requirements.txt file

  ```
  pip install flask
  pip freeze >> requirements.txt
  ```

4. Exit the container

  ```
  exit
  ```

### Run the flask app using code shared on local machine

1. Get the ip address of the Kubernetes VM

  ```
  minikube ip
  ```

2. Start the container with the bash command

  ```
  docker run -it --rm -v /ws:/ws -p 5000:5000 flask-kube bash
  ```

3. Change to the current directory on the container

  ```
  cd /ws
  ```

4. Run the Flask app

  ```
  FLASK_APP=app.py flask run --host=0.0.0.0
  ```

5. Using the ip address in step 1 above open the browser

  ```
  http://192.168.99.100:5000/
  ```

### Run the flask app using code copied to the container

1. Get the ip address of the Kubernetes VM

  ```
  minikube ip
  ```

2. Start the container with the bash command

  ```
  docker run -it --rm -p 5000:5000 flask-kube
  ```

3. Using the ip address in step 1 above open the browser
http://192.168.99.100:5000/

### Run the Kubernetes container with the stateless app

1. Create a Kubernetes deployment
kubectl create -f k8s\deployment.yaml

2. Describe the deployment
kubectl describe deployment flask-kube-deployment

3. List the pods create by the deployment
kubectl get pods -l app=flask-kube

4. Describe a single pod
kubectl get pods -l app=flask-kube -o name | sed s#pods/## | xargs kubectl describe pod

### Create a Kubernetest service to access the app

1. Create a Kubernetes deployment
kubectl create -f k8s\service.yaml

2. Get the service created
kubectl get service flask-kube

3. Using the port from the previous step and the ip obtained earler open this address
http://192.168.99.100:32753/

4. Delete service & deployment
kubectl delete service,deployment flask-kube

