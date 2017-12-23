install:
	pip install -r requirements.txt && python -m spacy download en

server:
	gunicorn --reload api.main:application

test:
	pytest **/tests.py

train:
	python text_recogn2ition/train.py

trainer:
	npm run rasa-nlu-trainer

download_data:
	mkdir -p data
	python -c 'import scripts.download_data'

upload_data:
	python -c 'import scripts.upload_data'

create_db:
	python -c 'import scripts.create_db'

clean_db:
	rm database.sqlite

clean_data:
	rm -rf data