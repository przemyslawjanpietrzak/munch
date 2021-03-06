[![Build Status](https://travis-ci.org/przemyslawjanpietrzak/munch.svg?branch=develop)](https://travis-ci.org/przemyslawjanpietrzak/munch) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Edvard Munch

/mʊŋk/ Norwegian painter whose intensely evocative treatment of psychological themes built upon some of the main tenets of late 19th-century Symbolism and greatly influenced German Expressionism in the early 20th century.

### Chatbot
For finding painting purpose. Base on Rasa_NLU natural language processing, Falcon HTTP handling.

Link: [http://munch.today/](http://munch.today/index.html)

![alt tag](https://przemyslawjanpietrzak.github.io/munch-screenshot.png)

### Run 

`docker pull przemyslawjanpietrzak/munch:first` pull docker image

`docker run -i -t --network host przemyslawjanpietrzak/munch:first` run docker container on port 8000

### Build
`make install` - install python's libs and spyCy en package

`make download_data` - download cleaned csv data from S3 bucket or clean data by clean_data jupyter notebook file.

`make train` - train dataset from text_recognition/data.json file

`make create_db` - create sqlite database with data from data/data.csv file

`make test` - run tests (ofc)

`make server` - run http server on your localhost

`make clean` - remove all dist files

`docker build -t munch .` - build docker container

### Trainer

To run rasa trainer:

`make install-dev`

`npm run trainer`
