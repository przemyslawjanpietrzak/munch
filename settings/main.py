import os


BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

S3_BUCKET_NAME = 'munch-chatbot'
AWS_PROFILE_NAME = 'munch'

ENVIRONMENT_KEY = 'ENVIRONMENT'
ENVIRONMENT_CI = 'CI'

AWS_SECRET_ACCESS_KEY = 'MUNCH_AWS_SECRET_ACCESS_KEY'
AWS_ACCESS_KEY_ID = 'MUNCH_AWS_ACCESS_KEY_ID'
