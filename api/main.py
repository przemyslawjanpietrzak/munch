from api.views import PaintingView
from api.models import db

import falcon


class App(falcon.API):
    def __init__(self, *args, **kwargs):
        super(App, self).__init__(*args, **kwargs)

        self.add_route('/painting/{question}', PaintingView())

        db.bind(provider='sqlite', filename='/home/przemyslaw/code/munch/database.sqlite')
        db.generate_mapping()


application = App()
