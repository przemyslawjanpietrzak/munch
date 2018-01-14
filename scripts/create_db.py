from api.models import db, Paint

from settings.main import BASE_DIR

from pony.orm import db_session, commit

import csv

db.bind(provider='sqlite', filename='{}/database.sqlite'.format(BASE_DIR), create_db=True)
db.generate_mapping(create_tables=True)


@db_session
def create_entities():
    with open('data/data.csv', 'r') as csvfile:
        data = csv.DictReader(csvfile)
        for row in data:
            paint = Paint(
                author=row['AUTHOR'],
                title=row['TITLE'],
                date=row['DATE'],
                technique=row['TECHNIQUE'],
                location=row['LOCATION'],
                url=row['URL'],
                form=row['FORM'],
                type_of=row['TYPE'],
                school=row['SCHOOL'],
                timeframe_start=row['TIMEFRAME_START'],
                timeframe_end=row['TIMEFRAME_END'],
            )
    commit()

create_entities()