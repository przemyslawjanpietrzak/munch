import json

import falcon

from api.managers import find_painting
from api.exceptions import PaintingNotFound


class PaintingView:

    def on_get(self, request, response, question):
        try:
            painting_url = find_painting(question)
            response.content_type = 'application/json'
            response.body = json.dumps({'url': painting_url})
        except PaintingNotFound:
            response.status = falcon.HTTP_404


class MainView:

    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200
        resp.content_type = 'text/html'
        with open('dist/{}'.format('index.html'), 'r') as f:
            resp.body = f.read()
