from rasa_nlu.model import Interpreter
from rasa_nlu.config import RasaNLUConfig

from settings import BASE_DIR

config = RasaNLUConfig('{}/backend/text_recognition/config.json'.format(BASE_DIR))
interpreter = Interpreter.load('{}/backend/text_recognition/models/default/model/'.format(BASE_DIR), config)


def parse_question(question):
    return interpreter.parse(question)
