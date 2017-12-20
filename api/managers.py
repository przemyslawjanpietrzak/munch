from api.models import Paint
from api.exceptions import PaintingNotFound

from text_recognition.main import parse_question

from pony.orm import select, db_session


def _get_query(incident_name, entity_value):
    if incident_name == 'find_by_title':
        return lambda paint: paint.title == entity_value
    if incident_name == 'find_by_author':
        return lambda paint: entity_value in paint.author


@db_session
def find_painting(question):

    parsed_question = parse_question(question)

    incident_name = parsed_question['intent']['name']
    entity = parsed_question['entities']
    if not entity:
        raise PaintingNotFound()

    entity_value = parsed_question['entities'][0]['value']
    
    paint = (Paint
        .select(_get_query(incident_name, entity_value))
        .first())

    if paint is None:
        raise PaintingNotFound()
    return paint.url
