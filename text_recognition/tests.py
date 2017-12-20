from text_recognition.main import parse_question


def test_find_by_title():
    parsed_question = parse_question('show me Allegory')

    assert parsed_question['entities'][0]['value'] == 'Allegory'
    assert parsed_question['intent']['name'] == 'find_by_title'


def test_find_by_author():
    parsed_question = parse_question('show me a picture painted by BLAKE')

    assert parsed_question['entities'][0]['value'] == 'BLAKE'
    assert parsed_question['intent']['name'] == 'find_by_author'
