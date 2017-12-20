install:
	pip install -r requirements.txt && python -m spacy download en

server:
	gunicorn --reload api.main:application

test:
	pytest **/tests.py

train:
	python text_recognition/train.py

trainer:
	 rasa-nlu-trainer