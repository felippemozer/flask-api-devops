FROM python:3.8.10-alpine3.13

EXPOSE 5000

WORKDIR /app

COPY requirements.txt .

RUN pip3 install -r requirements.txt

COPY wsgi.py .
COPY config.py .
COPY application application

CMD [ "python", "wsgi.py" ]