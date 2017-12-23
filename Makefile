install:
	pip install -r requirements.txt && python -m spacy download en

server:
	gunicorn --reload api.main:application

test:
	pytest **/tests.py

train:
	python text_recognition/train.py

trainer:
	npm run rasa-nlu-trainer

download_data:
	python -c 'import scripts.download_data'

create_db:
	python -c 'import scripts.create_db'

