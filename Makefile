python=~/.virtualenvs/munch/bin/python
gunicorn=~/.virtualenvs/munch/bin/gunicorn
pytest=~/.virtualenvs/munch/bin/pytest


install:
	pip install -r requirements.txt
	python -m spacy download en

install-dev:
	pip install -r requirements-dev.txt
	npm install

server:
	gunicorn --reload api.main:application

test:
	pytest text_recognition/test*.py  api/test*.py

train:
	python text_recognition/train.py

trainer:
	npm run rasa-nlu-trainer

download_data:
	mkdir -p data
	wget https://s3.eu-central-1.amazonaws.com/munch-chatbot/data.csv -O data/data.csv

upload_data:
	python -c 'import scripts.upload_data'

create_db:
	python -c 'import scripts.create_db'

clean_db:
	rm -f database.sqlite

clean_data:
	rm -rf data

clean_models:
	rm -rf text_recognition/models

clean:
	make clean_db
	make clean_data
	make clean_models