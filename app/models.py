from pony.orm import *

db = Database()

class Paint(db.Entity):
    author = Required(str)
    author_born_date = Required(str)
    author_born_place = Required(str)
    author_death_date = Required(str)
    author_death_place = Required(str)
    author = Required(str)
    title = Required(str)
    date = Required(str)
    technique = Required(str)
    location = Required(str)
    url = Required(str)
    form = Required(str)
    type_of = Required(str)
    school = Required(str)
    timeframe_start = Required(str)
    timeframe_end = Required(str)
