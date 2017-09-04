@echo off

for /f "usebackq tokens=*" %%a in (`docker-machine ip`) do set IP=%%a

docker build . -t flask
docker run -it --rm -p %IP%:5000:5000 --name my-flask flask

echo Open browser to http://%IP%:5000/
