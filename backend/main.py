from api.views import PaintingView, StaticResource
from api.models import db

from settings import BASE_DIR

import falcon


class App(falcon.API):
    def __init__(self, *args, **kwargs):
        super(App, self).__init__(*args, **kwargs)

        self.add_route('/painting/{question}', PaintingView())
        self.add_route('/{filename}', StaticResource())

        db.bind(provider='sqlite', filename='{}/database.sqlite'.format(BASE_DIR))
        db.generate_mapping()


application = App()



