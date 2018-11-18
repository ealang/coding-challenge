import pytest
from server import app

@pytest.fixture
def client():
    return app.test_client()

def test_post_returns_digest_of_message(client):
    response = client.post(
        '/messages',
        json={'message': '🦃'}
    )
    assert response.status_code == 201
    assert response.get_json() == {
        'digest': '98092b9f4358d9588f3e9fa4327af15607f81f1ce10e46e2d36181cf5d411f56'
    }

def test_post_returns_400_if_message_is_not_json(client):
    response = client.post('/messages', data='foo')
    assert response.status_code == 400

def test_post_returns_400_if_message_is_malformed_json(client):
    response = client.post(
        '/messages',
        data='{"message": ',
        content_type='application/json'
    )
    assert response.status_code == 400

def test_get_returns_404_when_digest_not_found(client):
    response = client.get('/messages/deadbeef')
    assert response.status_code == 404

def test_get_returns_message_when_digest_found(client):
    client.post('/messages', json={'message': 'bar'})
    response = client.get(
        '/messages/fcde2b2edba56bf408601fb721fe9b5c338d10ee429ea04fae5511b68fbf8fb9'
    )
    assert response.status_code == 200
    assert response.get_json() == {
        'message': 'bar'
    }
