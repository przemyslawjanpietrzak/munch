from api.models import Paint

from pony.orm import select, db_session


@db_session
def find_paint_url(name):
    paint = (Paint
        .select(lambda paint: paint.title == name)
        .first())

    if paint is None:
        return None
    return paint.url