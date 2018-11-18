FROM python:3.7.1-alpine3.8

ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

ADD gunicorn.py /gunicorn.py
ADD src/server.py /server.py

EXPOSE 80

CMD [ "gunicorn", "-c", "gunicorn.py", "--bind", "0.0.0.0:80", "server:app" ]
