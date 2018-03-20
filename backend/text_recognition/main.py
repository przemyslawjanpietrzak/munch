from rasa_nlu.model import Interpreter
from rasa_nlu.config import RasaNLUConfig

from settings import BASE_DIR

config = RasaNLUConfig('text_recognition/config.json')
interpreter = Interpreter.load('text_recognition/models/default/model/', config)


def parse_question(question):
    return interpreter.parse(question)
