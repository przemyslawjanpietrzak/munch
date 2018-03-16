FROM ubuntu:xenial

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    gcc \
    git \
    libpq-dev \
    wget \
    make \
    pkg-config \
    python3 \
    python3-dev \
    python-pip \
    && apt-get autoremove -y \
    && apt-get clean

WORKDIR /code
ADD . /code
ADD database.sqlite /code/database.sqlite

RUN pip install -U virtualenv
RUN pip install --upgrade pip
RUN virtualenv -p python3 ~/.virtualenvs/munch

RUN make install
RUN make train
RUN make test

CMD ["make", "server"]
EXPOSE 8000
