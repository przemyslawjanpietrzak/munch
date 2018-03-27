FROM  python:3.6.4-slim-stretch

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    wget \
    make \
    && apt-get autoremove -y \
    && apt-get clean

WORKDIR /code
ADD . /code

RUN pip install -r requirements.txt
RUN python -m spacy download en

RUN pytest . -vvv

CMD gunicorn main:application --workers=2 --bind=0.0.0.0:8000
EXPOSE 80
