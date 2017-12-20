from api.main import application

from falcon import testing
import pytest



@pytest.fixture()
def client():
    return testing.TestClient(application)


def test_painting_not_found(client):
    result = client.simulate_get('/painting/Scream')
    assert result.status_code == 404


def test_find_painting_by_name(client):
    result = client.simulate_get('/painting/show me Allegory')
    assert result.status_code == 200
    assert result.content == b'https://www.wga.hu/html/a/aachen/allegory.html'

def test_find_painting_by_title(client):
    result = client.simulate_get('/painting/show me a picture painted by BLAKE')
    assert result.status_code == 200
    assert result.content == b'https://www.wga.hu/html/b/blake/00lear.html'
