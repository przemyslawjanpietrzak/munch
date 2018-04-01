from falcon import testing

import pytest

from main import application


@pytest.fixture()
def client():
    return testing.TestClient(application)


def test_painting_not_found(client):
    result = client.simulate_get('/painting/Scream')
    assert result.status_code == 404


def test_find_painting_by_name(client):
    result = client.simulate_get('/painting/show me Allegory')
    assert result.status_code == 200
    assert result.headers['content-type'] == 'application/json'
    assert result.content == b'{"url": "https://www.wga.hu/html/a/aachen/allegory.html"}'


def test_find_painting_by_name1(client):
    result = client.simulate_get('/painting/show me Starry Night')
    assert result.status_code == 200
    assert result.headers['content-type'] == 'application/json'
    assert result.content == b'{"url": "https://www.wga.hu/html/g/gogh_van/12/cypres01.html"}'


def test_find_painting_by_title(client):
    result = client.simulate_get('/painting/show me a picture painted by Blake')
    assert result.status_code == 200
    assert result.headers['content-type'] == 'application/json'
    assert result.content == b'{"url": "https://www.wga.hu/html/b/blake/00lear.html"}'


def test_static_files(client):
    result = client.simulate_get('/index.html')
    assert result.status_code == 200
    assert result.headers['content-type'] == 'text/html'

    result = client.simulate_get('/style.css')
    assert result.status_code == 200
    assert result.headers['content-type'] == 'text/css'

    result = client.simulate_get('/script.js')
    assert result.status_code == 200


def test_static_files_unauthorized_files(client):
    result = client.simulate_get('/password.txt')
    assert result.status_code == 403
