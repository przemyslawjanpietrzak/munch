from api.views import PaintingView, StaticResource, MainView
from api.models import db

import falcon


class App(falcon.API):
    def __init__(self, *args, **kwargs):
        super(App, self).__init__(*args, **kwargs)

        self.add_route('/painting/{question}', PaintingView())
        self.add_route('/{filename}', StaticResource())
        self.add_route('/', MainView())

        db.bind(provider='sqlite', filename='database.sqlite')
        db.generate_mapping()


application = App()
