from api.managers import find_paint_url

import falcon


class PaintView:

    def on_get(self, request, response, name):
        paint_url = find_paint_url(name)
        if paint_url is None:
            response.status = falcon.HTTP_404
        response.body = paint_url