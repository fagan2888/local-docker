# local-docker

* Source code - [Bitbucket][1]
* Author - Gavin Noronha

[1]: 

## About

This project provides a Docker containers running on Windows or a Mac using
[Docker toolbox][10], the [Docker command line][20] and [Docker compose][30].
Also run Docker using [Kubernetes][40], [Minikube][50] and [Kubectl][60]

[10]: https://www.docker.com/products/docker-toolbox
[20]: https://docs.docker.com/engine/reference/commandline/cli/
[30]: https://docs.docker.com/compose/
[40]: https://kubernetes.io/
[50]: https://github.com/kubernetes/minikube
[60]: https://kubernetes.io/docs/user-guide/kubectl-overview/

It creates an Ubuntu container in which to develop software and run the
Docker commands and the rest of the Docker containers are created as
[sibling][100] containers.

[100]: https://www.develves.net/blogs/asd/2016-05-27-alternative-to-docker-in-docker/

## [Run Docker using Docker machine](doc/docker-machine.md)

## [Run Docker using Minikube](doc/minikube.md)

## Miscellaneous

### Install Minimal Jupyter notebook
1. Pull minimal Jupyter notebook
docker pull jupyter/minimal-notebook

2. Run IPython
docker run -ti --rm --name ipython jupyter/minimal-notebook start.sh ipython

Monitor containers using cadvisor
docker run                                      \
  --volume=/:/rootfs:ro                         \
  --volume=/var/run:/var/run:rw                 \
  --volume=/sys:/sys:ro                         \
  --volume=/var/lib/docker/:/var/lib/docker:ro  \
  --publish=8080:8080                           \
  --detach=true                                 \
  --name=cadvisor                               \
  google/cadvisor:latest

### Links

* [ModHeader](https://chrome.google.com/webstore/detail/modheader/idgpnmonknjnojddfkpgkljpfnnfcklj?hl=en)

* [Python Elasticsearch](https://tryolabs.com/blog/2015/02/17/python-elasticsearch-first-steps/)

* [Python Elasticsearch dsl]( https://github.com/elastic/elasticsearch-dsl-py)

* [Redshift, Athena, S3](https://news.ycombinator.com/item?id=13916030)

* [Kubernetes with Flask](http://louistiao.me/posts/re-implementing-the-kubernetes-guestbook-example-with-flask-and-nginx/)

* [Kubectl]( https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-via-curl)

* [Redis & Flask](http://blog.apcelent.com/scaling-python-microservices-kubernetes.html)

* [Redis Queue & Flask](http://louistiao.me/posts/walkthrough-deploying-a-flask-app-with-redis-queue-rq-workers-and-dashboard-using-kubernetes/)

* [Kompose](http://kompose.io/)

## Requirements

The following software is needed to get the software from github and run
Vagrant. The Git environment also provides an [SSH client][200] for Windows.

* [Docker toolbox][210]
* [Git][220]

[200]: http://en.wikipedia.org/wiki/Secure_Shell
[210]: https://www.docker.com/products/docker-toolbox
[220]: http://git-scm.com/
