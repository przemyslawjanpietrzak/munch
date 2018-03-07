FROM python:3.5

WORKDIR /
ADD . /

RUN make install
RUN make download_data
RUN make train
RUN make create_db
RUN make test

CMD ["make", "server"]
EXPOSE 8000
