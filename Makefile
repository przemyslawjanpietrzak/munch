python=~/.virtualenvs/munch/bin/python
gunicorn=~/.virtualenvs/munch/bin/gunicorn
pytest=~/.virtualenvs/munch/bin/pytest
pip=~/.virtualenvs/munch/bin/pip

install:
	pip install -r requirements.txt
	python -m spacy download en

install-dev:
	pip install -r requirements-dev.txt

build-webapp:
	npm run build

server:
	gunicorn api.main:application -workers 2 --bind 0.0.0.0:8000

test:
	cd backend ; pytest . -vvv ; cd ..

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
	python -c 'import backend.create_db'

build_front:
	cd frontend ; npm install && npm run build ; cd ..


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

provision:
	sudo apt-get update
	sudo apt-get install \
		apt-transport-https \
		ca-certificates \
		curl \
		software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable"
	sudo apt-get update
	sudo apt-get install docker-ce

	sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	docker-compose --version

	sudo usermod -aG docker ${USER}

	https://github.com/przemyslawjanpietrzak/munch
	cd munch