from api.models import Paint
from api.exceptions import PaintingNotFound

from text_recognition.main import parse_question

from pony.orm import select, db_session


@db_session
def find_painting(name):

    parsed_question = parse_question(name)

    incident_name = parsed_question['intent']['name']
    entity_value = parsed_question['entities'][0]['value']
    
    paint = (Paint
        .select(lambda paint: paint.title == entity_value)
        .first())

    if paint is None:
        raise PaintingNotFound()
    return paint.url
