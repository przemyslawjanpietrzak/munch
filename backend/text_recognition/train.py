from rasa_nlu.converters import load_data
from rasa_nlu.config import RasaNLUConfig
from rasa_nlu.components import ComponentBuilder
from rasa_nlu.model import Trainer


builder = ComponentBuilder(use_cache=True)  
training_data = load_data('text_recognition/data.json')
trainer = Trainer(RasaNLUConfig('text_recognition/config.json'), builder)
trainer.train(training_data)
model_directory = trainer.persist('text_recognition/models/', fixed_model_name='model')