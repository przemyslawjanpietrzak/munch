from api.main import application

from falcon import testing
import pytest



@pytest.fixture()
def client():
    return testing.TestClient(application)


def test_paint_not_found(client):
    result = client.simulate_get('/paint/Scream')
    assert result.status_code == 404


def test_find_paint_by_name(client):
    result = client.simulate_get('/paint/The%20Ancient%20of%20Days')
    assert result.status_code == 200
    assert result.content == b'https://www.wga.hu/html/b/blake/01ancien.html'

