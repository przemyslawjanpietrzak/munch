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

RUN make install
RUN make train
RUN make test

CMD ["make", "server"]
EXPOSE 80
