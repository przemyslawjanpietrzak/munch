from rasa_nlu.converters import load_data
from rasa_nlu.config import RasaNLUConfig
from rasa_nlu.components import ComponentBuilder
from rasa_nlu.model import Trainer

from settings import BASE_DIR

builder = ComponentBuilder(use_cache=True)
training_data = load_data('{}/text_recognition/data.json'.format(BASE_DIR))
trainer = Trainer(RasaNLUConfig('{}/text_recognition/config.json'.format(BASE_DIR)), builder)
trainer.train(training_data)
model_directory = trainer.persist('{}/text_recognition/models/'.format(BASE_DIR), fixed_model_name='model')
