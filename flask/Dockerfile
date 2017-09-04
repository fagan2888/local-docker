FROM python:alpine3.6

ADD . /code

WORKDIR /code

RUN pip3 install -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python"]

CMD ["app.py"]
