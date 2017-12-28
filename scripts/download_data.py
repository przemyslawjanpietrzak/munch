from settings.main import S3_BUCKET_NAME,\
    AWS_PROFILE_NAME,\
    ENVIRONMENT_KEY,\
    ENVIRONMENT_CI,\
    AWS_SECRET_ACCESS_KEY,\
    AWS_ACCESS_KEY_ID

import boto3
import botocore

import os


def _get_env_value(key):
    return os.environ[key]  


print(os.environ['test42'])

if ENVIRONMENT_KEY in os.environ and os.environ[ENVIRONMENT_KEY] == ENVIRONMENT_CI:
    s3 = boto3.resource(
        's3',
        aws_access_key_id=_get_env_value(AWS_ACCESS_KEY_ID),
        aws_secret_access_key=_get_env_value(AWS_SECRET_ACCESS_KEY)
    )
else:
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
