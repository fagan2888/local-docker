#!/bin/bash

docker build . -t flask
docker run -it --rm -p 0.0.0.0:5000:5000 --name my-flask flask

