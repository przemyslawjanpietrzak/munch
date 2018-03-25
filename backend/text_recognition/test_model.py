from text_recognition.main import parse_question


def test_find_by_title():
    parsed_question = parse_question('show me Johann August')

    assert parsed_question['entities'][0]['value'] == 'Johann August'
    assert parsed_question['intent']['name'] == 'find_by_title'


def test_find_by_title1():
    parsed_question = parse_question('show me Starry Night')

    assert parsed_question['entities'][0]['value'] == 'Starry Night'
    assert parsed_question['intent']['name'] == 'find_by_title'


def test_find_by_author():
    parsed_question = parse_question('show me a picture painted by Blake')

    assert parsed_question['entities'][0]['value'] == 'Blake'
    assert parsed_question['intent']['name'] == 'find_by_author'
