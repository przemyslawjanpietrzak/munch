
from settings.secrets import SECRET_ACCESS_KEY

import boto3
import botocore


s3 = boto3.resource('s3')

    
def download_file():
    try:
        s3.Bucket('munch-chatbot').download_file('data.csv', 'data/data.csv')
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == "404":
            print("The object does not exist.")
        else:
            raise


download_file()
