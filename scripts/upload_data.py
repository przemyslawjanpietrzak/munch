
from settings.main import S3_BUCKET_NAME, AWS_PROFILE_NAME

import boto3
import botocore

session = boto3.Session(profile_name=AWS_PROFILE_NAME)
s3 = session.resource('s3')

def open_file(path):
    with open(path, 'r') as file:
        return file.read()
    

def upload(path, key):
    s3.Bucket(S3_BUCKET_NAME).put_object(
        ACL='public-read',
        Body=open_file(path),
        Key=key
    )


upload('data/data.csv', 'data.csv')
# upload('data/new.xls', 'new.xls')
