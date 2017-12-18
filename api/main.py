from api.views import PaintView
from api.models import db

import falcon


class App(falcon.API):
    def __init__(self, *args, **kwargs):
        super(App, self).__init__(*args, **kwargs)

        self.add_route('/paint/{name}', PaintView())

        db.bind(provider='sqlite', filename='/home/przemyslaw/code/munch/database.sqlite')
        db.generate_mapping()


application = App()
