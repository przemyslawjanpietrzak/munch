from pony.orm import Required, Database


db = Database()


class Paint(db.Entity):
    author = Required(str)
    title = Required(str)
    date = Required(str)
    technique = Required(str)
    location = Required(str)
    url = Required(str)
    form = Required(str)
    type_of = Required(str)
    school = Required(str)
    timeframe_start = Required(int)
    timeframe_end = Required(int)
