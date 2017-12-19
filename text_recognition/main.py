from rasa_nlu.model import Metadata, Interpreter
from rasa_nlu.config import RasaNLUConfig


config = RasaNLUConfig("config.json")


interpreter = Interpreter.load('./models/default/model_20171218-002056/', config)


def parse_question(question):
    return interpreter.parse(question)
