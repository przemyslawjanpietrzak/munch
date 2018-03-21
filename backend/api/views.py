import json

import falcon

from settings import BASE_DIR

from api.managers import find_painting
from api.exceptions import PaintingNotFound


class PaintingView:

    def on_get(self, request, response, question):
        try:
            painting_url = find_painting(question)
            response.content_type = 'application/json'
            response.body = json.dumps({'url': painting_url })
        except PaintingNotFound:
            response.status = falcon.HTTP_404


class StaticResource:

    def on_get(self, req, resp, filename):
        if filename not in ['index.html', 'style.css', 'script.js']:
            resp.status = falcon.HTTP_403
            return
        resp.status = falcon.HTTP_200
        resp.content_type = 'text/html' if filename == 'index.html' else 'text/css'
        with open('dist/{}'.format(filename), 'r') as f:
            resp.body = f.read()
