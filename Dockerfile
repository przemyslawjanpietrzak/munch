FROM python:3.5-slim

WORKDIR /code
ADD . /code

RUN apt-get update && apt-get install build-essential curl wget -y
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN make install
RUN make build-webapp
RUN make download_data
RUN make train
RUN make create_db
RUN make test

CMD ["make", "server"]
EXPOSE 8000
