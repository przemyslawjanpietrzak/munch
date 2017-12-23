
from settings.main import BUCKET_NAME

import boto3
import botocore


s3 = boto3.resource('s3')


def open_file(path):
    with open(path, 'r') as file:
        return file.read()
    

def upload(path, key):
    s3.Bucket(BUCKET_NAME).put_object(
        ACL='public-read',
        Body=open_file(path),
        Key=key
    )


upload('Makefile', 'Makefile')

