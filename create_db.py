from app.models import *
import pandas as pd

db.bind(provider='sqlite', filename='/home/przemyslaw/code/munch/database.sqlite', create_db=True)
db.generate_mapping(create_tables=True)
set_sql_debug(True)

data = pd.read_csv('./data_clean1.csv')


@db_session
def create_entities():
    for _, item in data.iterrows():
        p = Paint(
            author=item['AUTHOR'],
            author_born_date=item['BORN_DATE'],
            author_born_place=str(item['BORN_PLACE']),
            author_death_date=str(item['DIE_DATE']),
            author_death_place='placeholder',
            title=item['TITLE'],
            date=item['DATE'],
            technique=item['TECHNIQUE'],
            location=item['LOCATION'],
            url=item['URL'],
            form=item['FORM'],
            type_of=item['TYPE'],
            school=item['SCHOOL'],
            timeframe_start='placeholder',
            timeframe_end='placeholder',
        )
        commit()
create_entities()
