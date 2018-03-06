FROM python:3.5

WORKDIR /app
ADD . /app

RUN make install
RUN make download_data
RUN make train
RUN make create_db

EXPOSE 8000

CMD ["make", "server"].