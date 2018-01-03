from api.views import PaintingView
from api.models import db

from settings.main import BASE_DIR

import falcon


class App(falcon.API):
    def __init__(self, *args, **kwargs):
        super(App, self).__init__(*args, **kwargs)

        self.add_route('/painting/{question}', PaintingView())

        db.bind(provider='sqlite', filename='{}/database.sqlite'.format(BASE_DIR))
        db.generate_mapping()


application = App()
