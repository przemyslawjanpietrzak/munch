FROM ubuntu:xenial

RUN sed -i 's/archive.ubuntu.com/mirror.us.leaseweb.net/' /etc/apt/sources.list \
    && sed -i 's/deb-src/#deb-src/' /etc/apt/sources.list \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    build-essential \
    ca-certificates \
    gcc \
    git \
    libpq-dev \
    wget \
    make \
    pkg-config \
    python3 \
    python3-dev \
    python-pip \
    aria2 \
    && apt-get autoremove -y \
    && apt-get clean

WORKDIR /code
ADD . /code

RUN pip install -U virtualenv
RUN pip install --upgrade pip
RUN virtualenv -p python3 ~/.virtualenvs/munch

RUN make clean
RUN make install
RUN make download_data
RUN make train
RUN make create_db
RUN make test

CMD ["make", "server"]
EXPOSE 8000
