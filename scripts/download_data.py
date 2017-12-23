
from settings.main import BUCKET_NAME

import boto3
import botocore


s3 = boto3.resource('s3')

    
def download_file(file_name):
    try:
        s3.Bucket(BUCKET_NAME).download_file(file_name, 'data/{}'.format(file_name))
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == "404":
            print("The object does not exist.")
        else:
            raise


download_file('data.csv')
download_file('new.xls')
