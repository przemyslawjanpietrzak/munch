from settings.main import S3_BUCKET_NAME, AWS_PROFILE_NAME

import boto3
import botocore


session = boto3.Session(profile_name=AWS_PROFILE_NAME)
s3 = session.resource('s3')

    
def download_file(file_name):
    try:
        s3.Bucket(S3_BUCKET_NAME).download_file(file_name, 'data/{}'.format(file_name))
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == "404":
            print("The object does not exist.")
        else:
            raise


download_file('data.csv')
# download_file('new.xls')
