import csv

from pony.orm import db_session, commit

from api.models import db, Paint

from settings import BASE_DIR


db.bind(provider='sqlite', filename='database.sqlite', create_db=True)
db.generate_mapping(create_tables=True)


@db_session
def create_entities():
    with open('{}/data/data.csv'.format(BASE_DIR), 'r') as csvfile:
        data = csv.DictReader(csvfile)
        for row in data:
            paint = Paint(  # noqa: F841
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
