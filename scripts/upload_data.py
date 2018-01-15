
from settings.main import S3_BUCKET_NAME, AWS_PROFILE_NAME

import boto3
import botocore

session = boto3.Session(profile_name=AWS_PROFILE_NAME)
s3 = session.resource('s3')

def open_file(path):
    with open(path, 'rb') as file:
        return file.read()
   

def upload(path, key):
    s3.Bucket(S3_BUCKET_NAME).put_object(
        ACL='public-read',
        Body=open_file(path),
        Key=key
    )


upload('data/data.csv', 'data.csv')
upload('text_recognition/models/default/model/crf_model.pkl', 'crf_model.pkl')
upload('text_recognition/models/default/model/entity_synonyms.json', 'entity_synonyms.json')
upload('text_recognition/models/default/model/intent_classifier.pkl', 'intent_classifier.pkl')
upload('text_recognition/models/default/model/metadata.json', 'metadata.json')
upload('text_recognition/models/default/model/training_data.json', 'training_data.json')
upload('data/new.xls', 'new.xls')
