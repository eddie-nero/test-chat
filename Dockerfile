FROM python:3.8
ENV PYTHONUNBUFFERED=1
WORKDIR /opt/chat
COPY Pipfile /opt/chat/
RUN apt-get update && apt-get install -y postgresql-client
RUN pip install pipenv && pipenv lock -r > requirements.txt
RUN pip install uwsgi
RUN pip install -r requirements.txt
COPY . /opt/chat/