from api.models import db, Paint

from settings.main import BASE_DIR

import pandas as pd
from pony.orm import db_session, commit


db.bind(provider='sqlite', filename='{}database.sqlite'.format(BASE_DIR), create_db=True)
db.generate_mapping(create_tables=True)

data = pd.read_csv('data/data.csv')

@db_session
def create_entities():
    for _, item in data.iterrows():
        p = Paint(
            author=item['AUTHOR'],
            title=item['TITLE'],
            date=item['DATE'],
            technique=item['TECHNIQUE'],
            location=item['LOCATION'],
            url=item['URL'],
            form=item['FORM'],
            type_of=item['TYPE'],
            school=item['SCHOOL'],
            timeframe_start=item['TIMEFRAME_START'],
            timeframe_end=item['TIMEFRAME_END'],
        )
    commit()


create_entities()
