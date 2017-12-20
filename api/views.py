from api.managers import find_painting
from api.exceptions import PaintingNotFound

import falcon


class PaintingView:

    def on_get(self, request, response, question):
        try:
            painting_url = find_painting(question)
            response.body = painting_url
        except PaintingNotFound:
            response.status = falcon.HTTP_404
        